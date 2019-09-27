var webpack = require('webpack');
var path = require('path');
var BUILD_DIR = path.resolve(__dirname, 'output/UniversalDashboard.MaterialUICarousel');
var SRC_DIR = path.resolve(__dirname);
var APP_DIR = path.resolve(__dirname, 'app');

module.exports = (env) => {
  const isDev = env == 'development' || env == 'isolated';

  return {
    entry: [APP_DIR + '/index.jsx'],
    output: {
      library: "MaterialUICarousel",
      libraryTarget: "var",
      path: BUILD_DIR,
      filename: isDev ? 'index.bundle.js' : 'index.[hash].bundle.js',
      publicPath: ""
    },
    module : {
      rules : [
        { test: /\.(js|jsx)$/, exclude: [/node_modules/], loader: 'babel-loader'}
      ]
    },
    externals: {
      UniversalDashboard: 'UniversalDashboard',
      react: 'react',
      'react-dom': 'reactdom',
      'react-router-dom': 'reactrouterdom'
    },
    resolve: {
      extensions: ['.json', '.js', '.jsx']
    },
    plugins: [],
   devtool: 'source-map',
  };
}


