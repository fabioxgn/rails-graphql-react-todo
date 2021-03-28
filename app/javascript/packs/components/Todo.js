import React from 'react'
import { useMutation } from 'react-apollo'
import { UpdateTodo, DestroyTodo, TodosQuery } from './operations.graphql'

function Todo (props) {
  const todo = props.todo

  const [updateTodo] = useMutation(UpdateTodo)
  const [destroyTodo] = useMutation(DestroyTodo, {
    update: (cache, { data: { destroyTodo } }) => {
      const destroyed = destroyTodo
      if (destroyed) {
        const currentTodos = cache.readQuery({ query: TodosQuery })
        cache.writeQuery({
          query: TodosQuery,
          data: { todos: currentTodos.todos.filter(todo => todo.id !== destroyed.id) }
        })
      }
    }
  })
  return (
    <li>
      <input
        className='mr-2' type='checkbox' checked={todo.completed} id={`todo_${todo.id}`}
        onChange={e => {
          updateTodo({ variables: { id: e.target.id.replace(/^todo_/, ''), completed: e.target.checked } })
        }}
      />
      {todo.description}
      <a href='#' className='text-reset'>
        <i
          className='bi-trash' id={`todo_${todo.id}`}
          onClick={e => {
            destroyTodo({ variables: { id: e.target.id.replace(/^todo_/, '') } })
          }}
        />
      </a>
    </li>
  )
}

export default Todo
