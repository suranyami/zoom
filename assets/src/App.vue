<template>
  <div class="container">
    <div id="app">
      <h1>{{ msg }}</h1>
      <h2>The following was loaded over Graphql:</h2>
      <h3>User: {{ user.name }}</h3>
      <h3>Age: {{ user.age }}</h3>

      <table class="table table-striped table-bordered">
        <thead>
          <tr>
            <th>Name</th>
            <th>Age</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="user in users">
            <td>{{ user.name }}</td>
            <td>{{ user.age }}</td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script>
import gql from 'graphql-tag'

export default {
  name: 'app',
  data () {
    return {
      msg: 'Hi, Everyone!',
      user: {
        name: '',
        age: ''
      },
      users: [

      ]
    }
  },
  apollo: {
    user: gql`query {
      user(id: 1) {
        name
        age
      }
    }`,
    users: gql`query {
      users {
        name
        age
      }
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
          this.users.push(user)
          console.log(user)
          return(user)
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
