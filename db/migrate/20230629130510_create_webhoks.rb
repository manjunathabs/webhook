class CreateWebhoks < ActiveRecord::Migration[5.2]
  def change
    create_table :webhoks do |t|
      t.string :url

      t.timestamps
    end
  end
end
