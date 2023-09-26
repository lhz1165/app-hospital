'use strict'
const merge = require('webpack-merge')
const prodEnv = require('./prod.env')

module.exports = merge(prodEnv, {
  NODE_ENV: '"development"',
  // 使用nginx访问
  // BASE_API: '"http://localhost:9001"',
  // 使用gateway访问
  BASE_API: '"http://localhost:9999"',
})
