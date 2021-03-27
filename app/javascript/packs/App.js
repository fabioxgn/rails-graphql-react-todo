import React from 'react'
import ApolloClient from 'apollo-boost'
import { ApolloProvider } from 'react-apollo'
import Todos from './components/Todos'
import AddTodo from './components/NewTodo'

const client = new ApolloClient({
  fetchOptions: {
    credentials: 'same-origin'
  },
  request: (operation) => {
    const csrfToken = document.querySelector('meta[name=csrf-token]').getAttribute('content')
    operation.setContext({
      headers: { 'X-CSRF-Token': csrfToken }
    })
  },
  uri: 'http://localhost:3000/graphql'
})

function App () {
  return (
    <ApolloProvider client={client}>
      <div className='container'>
        <nav className='navbar navbar-dark bg-primary mb-3'>
          <a className='navbar-brand' href='#'>React and GraphQL - Todo Application</a>
        </nav>
        <div>
          <AddTodo />
          <Todos />
        </div>
      </div>
    </ApolloProvider>
  )
}

export default App
