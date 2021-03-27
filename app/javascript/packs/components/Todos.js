import React from 'react'
import { Query } from 'react-apollo'
import { TodosQuery } from "./operations.graphql";

import Todo from './Todo'

const Todos = () => (
  <Query query={TodosQuery}>
    {({ loading, error, data }) => {
      if (loading) return <p>Loading ...</p>
      if (error) return <p>Error: {error}</p>

      const listItems = data.todos.map((todo) => (<Todo key={todo.id} todo={todo} />))
      return (<ul className='list-unstyled'>{listItems}</ul>)
    }}
  </Query>
)

export default Todos
