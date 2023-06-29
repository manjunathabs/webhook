class AddSecretToWebhoks < ActiveRecord::Migration[5.2]
  def change
    add_column :webhoks, :secret, :string
  end
end
