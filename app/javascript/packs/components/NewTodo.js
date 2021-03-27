import React from 'react'
import { useMutation } from 'react-apollo'
import { AddTodo, TodosQuery } from './operations.graphql'

function NewTodo () {
  let input
  const [addTodo] = useMutation(AddTodo, {
    update: (cache, { data: { addTodo } }) => {
      const todo = addTodo.todo
      if (todo) {
        const currentTodos = cache.readQuery({ query: TodosQuery })
        cache.writeQuery({
          query: TodosQuery,
          data: { todos: [todo].concat(currentTodos.todos) }
        })
      }
    }
  })

  return (
    <div className='form-group'>
      <form
        className='form-inline'
        onSubmit={e => {
          e.preventDefault()
          addTodo({ variables: { description: input.value } })
          input.value = ''
        }}
      >
        <input
          className='form-control'
          placeholder='Buy milk...'
          ref={node => { input = node }}
        />
        <button className='btn btn-primary ml-2' type='submit'>Add Todo</button>
      </form>
    </div>
  )
}

export default NewTodo
