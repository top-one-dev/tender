class CreateJoinTableCompanyUser < ActiveRecord::Migration[5.0]
  def change
    create_join_table :companies, :users do |t|
      t.index [:company_id, :user_id]
      t.index [:user_id, :company_id]

      t.timestamps
    end
  end
end
