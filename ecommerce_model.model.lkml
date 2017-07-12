connection: "thelook"

include: "*.view.lkml"         # include all views in this project
include: "*.dashboard.lookml"  # include all dashboards in this project

datagroup: ecommerce_data {
  sql_trigger: SELECT CURDATE() ;;
}


explore: inventory_items {
join: products {
  sql_on: ${inventory_items.product_id}=${products.id} ;;
  relationship: many_to_one
}
join: order_items {
  sql_on: ${inventory_items.id}=${order_items.inventory_item_id} ;;
  relationship: one_to_many

}
join: orders {
  sql_on: ${order_items.order_id}=${orders.id} ;;
  relationship: many_to_one
}
}
explore: users {
  join: orders {
    sql_on: ${users.id}=${orders.user_id} ;;
    relationship: one_to_many
  }
  join: order_items {
    sql_on: ${orders.id}=${order_items.order_id} ;;
    relationship: one_to_many
  }
  join: inventory_items {
    sql_on: ${order_items.inventory_item_id}=${inventory_items.id} ;;
    relationship: many_to_one
  }
  join: products {
    sql_on: ${inventory_items.product_id}=${products.id} ;;
    relationship: many_to_one
  }
  persist_with: ecommerce_data
}

explore: customer_history {
  join: orders {
    sql_on: customer_history.id=orders.user_id ;;
    relationship: one_to_many
}
join: order_items {
  sql_on: ${orders.id}=${order_items.order_id} ;;
  relationship: one_to_many
}
join: inventory_items {
  sql_on: ${order_items.inventory_item_id}=${inventory_items.id} ;;
  relationship:  many_to_one
}
join: products {
  sql_on: ${inventory_items.product_id}=${products.id} ;;
  relationship: many_to_one
}
}
