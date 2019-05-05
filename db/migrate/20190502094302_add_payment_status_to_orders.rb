class AddPaymentStatusToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :payment_status, :string, after: :status
  end
end
