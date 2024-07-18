import path from 'path';
import rails from 'esbuild-rails';
import * as esbuild from 'esbuild';

const watch = process.argv.includes('--watch')
const minify = process.argv.includes('--minify')
const metafile = process.argv.includes('--metafile')

console.log("WATCH: ", watch)
console.log("MINIFY: ", minify)
console.log("METAFILE: ", metafile)

let ctx = await esbuild.context({
  logLevel: 'info',
  target: 'es2020',
  sourcemap: watch ? 'inline' : false,
  define: { 
    'process.env.NODE_ENV': `"${process.env.NODE_ENV}"`,
    'global': 'window',
    'process.env.NODE_DEBUG': '""',
    'define': 'undefined'
  },
  platform: 'browser',
  entryPoints: [
    "app/javascript/application.js", 
  ],
  bundle: true,
  metafile,
  minify,
  publicPath: "/assets",
  nodePaths: ['./node_modules'],
  assetNames: '[name]-[hash].digested',
  outdir: 'app/assets/builds',
  plugins: [
    rails()
  ]
})

if( watch ){
  await ctx.watch()
  let { host, port } = await ctx.serve({
    port: 3001,
    servedir: 'app/assets/builds',
  })
} else {
  ctx.rebuild()
  ctx.dispose()
}
