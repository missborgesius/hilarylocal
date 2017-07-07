view: order_items {
  sql_table_name: demo_db.order_items ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.order_id ;;
  }

  dimension_group: returned {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.returned_at ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  dimension: return_age {
    type: number
    label: "Days to Return"
    sql: DATEDIFF(DATE(order_items.returned_at), DATE(orders.created_at)) ;;
  }
  measure: avg_return_age{
    type: average
    label: "Average Days to Return"
    sql:DATEDIFF(DATE(order_items.returned_at), DATE(orders.created_at)) ;;
  }

  measure: count {
    type: count
    drill_fields: [id, inventory_items.id, orders.id]
  }
  dimension: profit {
    type: number
    sql: ${TABLE}.sale_price-${inventory_items.cost} ;;
  }
  dimension: discount {
    type: number
    sql: ${products.retail_price}-${TABLE}.sale_price;;
    value_format_name: usd
  }
  measure: total_profit {
    type:  sum
    sql: ${profit} ;;
    value_format_name: usd
  }
  measure: average_profit {
    type:  average
    sql: ${profit} ;;
    value_format_name: usd
  }
  measure: average_discount {
    type: average
    sql: ${discount} ;;
    value_format_name: usd
  }

}
