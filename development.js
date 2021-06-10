import  webpack from "webpack"
import  path    from "path"
import  glob    from "glob"
import  _       from "lodash"
//import  {$, jQuery}     from "jquery"
import  MiniCssExtractPlugin    from "mini-css-extract-plugin";
import  CopyPlugin              from "copy-webpack-plugin";
import  ImageminPlugin          from "imagemin-webpack-plugin";
import  ImageminMozjpeg         from "imagemin-mozjpeg";

const MODE = (process.env.WEBPACK_ENV.trim() === "production")
    ? "production"
    : "development"
    ;
console.log("************** MODE: " + MODE + " **************");

module.exports = (env) => {
    const SITE_ID   = env.site;
    const targets   = _.filter(glob.sync("./sites/" + SITE_ID + "/module/**/*.js*"), (item) => {
        return (!item.match(/json$/));
    });
    if(targets.length === 0)
    {
        console.log("no javascript files are found.\n");
        process.exit(0);
    }
    const entries = {};
    targets.map(value => {
        const   getkey  = new RegExp("^\./sites/" + SITE_ID + "/module/([^.]+?)/views/(.+?)/scripts/([^/]+?)\.(js|jsx)$");
        const   key     = value.replace(getkey, "$1/$2");
        const   remext  = new RegExp("^(.+)\.(js|jsx)$");
        if(typeof entries[key] === "undefined")
        {
            entries[key]    = [];
        }
        entries[key].push(value.replace(remext, "$1"));
    });
    
    ////////////////////////////////////////////////////////////////////////////
    
    return  {
        mode:           MODE,
        devtool:        (MODE === "development") ? "inline-source-map" : false,
        target:         ["web", "es5"],
        watchOptions:
        {
            ignored:    /node_modules/
        },
        entry:          entries,
        output:
        {
            path:       path.resolve(__dirname, "sites/" + SITE_ID + "/public"),
            filename:   "[name]/js/bundle.min.js"
        },
        resolve: {
            alias: {
                "jquery-ui":        "jquery-ui/ui/widgets",
		"jquery-ui-css":    "jquery-ui/../../themes/base",
                base: path.resolve(__dirname, "sites/" + SITE_ID + "/module/__com/views/global/stylesheets/base")
            },
            extensions: [".js", ".jsx"],
            modules:    ["node_modules"]
        },
        module: {
            rules: [
                {
                    test:       /\.js[x]?$/,
                    exclude:    /node_modules/,
                    use: {
                        loader: "babel-loader",
                        options: {
                            presets: [
                                [
                                    "@babel/preset-env",
                                    {
                                        useBuiltIns: "usage",
                                        corejs: 3
                                    },
                                    "@babel/preset-react"
                                ]
                            ],
                            plugins: ["@babel/plugin-syntax-jsx", "@babel/plugin-transform-react-jsx"]
                        }
                    }
                },
                {
                    test:       /\.(sa|sc|c)ss$/,
                    exclude:    /node_modules/,
                    use: [
                        MiniCssExtractPlugin.loader,
                        {
                            loader:     "css-loader",
                            options: { url: true }  // embed base64 encoded images that are using at url() in scss
                        },
                        {
                            loader: "sass-loader",
                            options: {
                                additionalData: "@import '~base/_variables';"
                            }
                        }
                    ]
                },
                {
                    test:       /\.(gif|png|jpg|eot|wof|woff|woff2|ttf|svg)$/,
                    loader:     "url-loader"
                }
            ]
        },
        stats: {
            children:   true
        },
        plugins: [
            new MiniCssExtractPlugin({
                filename:   "[name]/css/bundle.min.css"
            }),
            new CopyPlugin({
                patterns: [
                    {
                        context:    "./sites/" + SITE_ID + "/assets/resources/images",
                        from:       "**/*",
                        to:         "__com/imgs",
                        noErrorOnMissing: true
                    },
                    {
                        context:    "./sites/" + SITE_ID + "/assets/resources/documents",
                        from:       "**/*",
                        to:         "__com/docs",
                        noErrorOnMissing: true
                    },
                    {
                        context:    "./sites/" + SITE_ID + "/assets/resources/favicons",
                        from:       "**/*",
                        to:         "__com/favicons",
                        noErrorOnMissing: true
                    },
                    {
                        context:    "./sites/" + SITE_ID + "/assets/resources/libraries",
                        from:       "**/*",
                        to:         "__com/libraries",
                        noErrorOnMissing: true
                    }
                ]
            }),
            new ImageminPlugin({
                test:                   /\.(jpe?g|png|gif|svg)$/i,
                cacheFolder:            "./caches/webpack",
                pngquant: {
                    quality:            "65-80"
                },
                gifsicle: {
                    interlaced:         false,
                    optimizationLevel:  1,
                    colors:             256
                },
                svgo: {},
                plugins: [
                    ImageminMozjpeg({
                        quality:        85,
                        progressive:    true
                    })
                ]
            })
            /*
            new webpack.ProvidePlugin({
                $:                  "jquery",
                jQuery:             "jquery",
                "window.jQuery":    "jquery",
                "window.$":         "jquery"
            })
             */
        ]
    };
};
