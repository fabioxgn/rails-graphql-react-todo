import React from 'react'

function Todo(props) {
  const todo = props.todo
  return <li>{todo.description}</li>
}

export default Todo
