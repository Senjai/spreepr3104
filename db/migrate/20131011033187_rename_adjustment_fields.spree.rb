# This migration comes from spree (originally 20130807024302)
class RenameAdjustmentFields < ActiveRecord::Migration
  def up
    remove_column :spree_adjustments, :originator_id
    remove_column :spree_adjustments, :originator_type

    add_column :spree_adjustments, :order_id, :integer

    # This enables the Spree::Order#all_adjustments association to work correctly
    Spree::Adjustment.reset_column_information
    Spree::Adjustment.find_each do |adjustment|
      adjustment.order = adjustment.adjustable
      adjustment.save
    end
  end
end
