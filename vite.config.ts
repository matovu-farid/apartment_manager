import { defineConfig } from 'vite'
import RubyPlugin from 'vite-plugin-ruby'
import FullReload from 'vite-plugin-full-reload'
import StimulusHMR from 'vite-plugin-stimulus-hmr'
import path from "path"


export default defineConfig({
  plugins: [
    RubyPlugin(),
    FullReload(['config/routes.rb', 'app/views/**/*'], { delay: 200 }),
    StimulusHMR(),
  ],
  resolve: {
    alias: [
      {
        find: "lib",
        replacement: path.resolve(__dirname, "app/javascript/lib"),
      },
      {
        find: "components",
        replacement: path.resolve(__dirname, "app/javascript/components"),
      },
      {
        find: "@components",
        replacement: path.resolve(__dirname, "node_modules/@components"),
      },
      {
        find: "@lib",
        replacement: path.resolve(__dirname, "node_modules/@lib"),
      }



    ],
  }
})
