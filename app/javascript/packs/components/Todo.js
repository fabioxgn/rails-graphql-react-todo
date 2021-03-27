import React from 'react'

const Todo = (props) => {
  const todo = props.todo
  return <li>{todo.description}</li>
}

export default Todo
