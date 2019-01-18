import Vue from 'vue'
import { setContext } from 'apollo-link-context'
import { InMemoryCache } from 'apollo-cache-inmemory'
import { ApolloClient } from 'apollo-client'
import { createHttpLink } from "apollo-link-http"
import { ApolloLink } from "apollo-link"
import { HttpLink } from 'apollo-link-http'
import VueApollo from 'vue-apollo'
import { hasSubscription } from "@jumpn/utils-graphql"
import * as AbsintheSocket from "@absinthe/socket"
import { createAbsintheSocketLink } from "@absinthe/socket-apollo-link"
import { Socket as PhoenixSocket } from "phoenix"
import App from './App.vue'

Vue.use(VueApollo)

const absintheSocket = AbsintheSocket.create(
  new PhoenixSocket("ws://localhost:4000/socket")
)
const absintheSocketLink = createAbsintheSocketLink(absintheSocket)

const link = new ApolloLink.split(
  operation => hasSubscription(operation.query),
  absintheSocketLink,
  createHttpLink({uri: "/graphql"})
)

const apolloClient = new ApolloClient({
  link,
  cache: new InMemoryCache(),
  connectToDevTools: true,
})

// Import our main app component, the top-level container for our app.

const apolloProvider = new VueApollo({
  defaultClient: apolloClient,
})

// Bootstrap the new Vue app. It grabs onto the div with id="app that we created in the Phoenix HTML.
// We pass the apolloProvider instance to it, so our components can all use the same connection.
new Vue({
  el: '#app',
  provide: apolloProvider.provide(),
  render: h => h(App)
})


const operation = `
subscription {
  userAdded {
    name
    age
  }
}`

const notifier = AbsintheSocket.send(absintheSocket, {operation})

const logEvent = eventName => (...args) => console.log(eventName, ...args)

const updatedNotifier = AbsintheSocket.observe(absintheSocket, notifier, {
  onAbort: logEvent("abort"),
  onError: logEvent("error"),
  onStart: logEvent("open"),
  onResult: logEvent("result")
})
