<template>
  <div id="app">
    <h1>User: {{ user.name }}</h1>
    <h1>Age: {{ user.age }}</h1>
    <h1>Number of Users: {{ countUsers }}</h1>
  </div>
</template>

<script>
import gql from 'graphql-tag'
export default {
  name: 'app',
  data () {
    return {
      user: {name: '', age: ''},
      countUsers: 0
    }
  },
  apollo: {
    user: gql`query {
      user(id: 1) {
        name
        age
      }
    }`,

    countUsers: gql`query {
      countUsers
    }`,

    $subscribe: {
      userAdded: {
        query: gql`subscription {
          userAdded {
            name
            age
          }
        }`,
        result(data) {
          const user = data.data.userAdded
          this.user = user
          return(user)
        }
      },

      countUsers: {
        query: gql`subscription {
          countUsers
        }`,
        result(data) {
          const countUsers = data.data.countUsers
          this.countUsers = countUsers
          return(countUsers)
        }
      }

    }
  }
}
</script>

<style lang="scss">
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
h1, h2 {
  font-weight: normal;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}
</style>
