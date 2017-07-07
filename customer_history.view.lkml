view: customer_history {
 derived_table: {
   sql:
  SELECT users.id as id,
  CONCAT(users.first_name," ",users.last_name) as full_name,
  users.first_name as first_name,
  users.last_name as last_name,
  MIN(orders.created_at) as first_order,
  MAX(orders.created_at) as last_order,
  COUNT(orders.id) as lifetime_orders,
  SUM(order_items.sale_price) as lifetime_revenue
  from users
  JOIN orders on users.id=orders.user_id
  JOIN order_items on orders.id=order_items.order_id
  WHERE orders.created_at is not null
  GROUP BY 1
  ;;
 }
dimension: id {
  primary_key: yes
  type: number
  sql: ${TABLE}.id ;;
}

dimension: full_name {
  type:  string
  sql: ${TABLE}.full_name ;;
}

dimension: first_name {
  type: string
  sql: ${TABLE}.first_name ;;
}

dimension: last_name {
  type: string
  sql: ${TABLE}.last_name ;;
}

dimension_group: first_order {
  type: time
  sql: ${TABLE}.first_order ;;
}

dimension_group: last_order {
  type: time
  sql: ${TABLE}.last_order ;;
}

dimension: lifetime_orders {
  type: number
  sql: ${TABLE}.lifetime_orders ;;
}

dimension: lifetime_revenue {
  type: number
  sql: ${TABLE}.lifetime_revenue ;;
  value_format_name: usd
}

}
