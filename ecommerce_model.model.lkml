connection: "thelook"

include: "*.view.lkml"         # include all views in this project
include: "*.dashboard.lookml"  # include all dashboards in this project

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
