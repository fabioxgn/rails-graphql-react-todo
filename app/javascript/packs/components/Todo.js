import React from 'react'
import { useMutation } from 'react-apollo'
import { UpdateTodo } from './operations.graphql'

function Todo (props) {
  const todo = props.todo

  const [updateTodo] = useMutation(UpdateTodo)
  return(
    <li>
      <input className='mr-2' type='checkbox' checked={todo.completed} id={`todo_${todo.id}`}
        onChange={e => {
          updateTodo({ variables: { id: e.target.id.replace(/^todo_/, ''), completed: e.target.checked } })
        }}
      />
      {todo.description}
    </li>
  )
}

export default Todo
