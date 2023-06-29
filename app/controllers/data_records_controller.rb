
class DataRecordsController < ApplicationController
    include HTTParty
  skip_before_action :verify_authenticity_token
  def create
    data_record = DataRecord.new(data_record_params)

    if data_record.save
      notify_webhooks(data_record)
      render json: { message: 'Data record created successfully' }, status: :created
    else
      render json: { error: data_record.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    data_record = DataRecord.find(params[:id])

    if data_record.update(data_record_params)
      notify_webhooks(data_record)
      render json: { message: 'Data record updated successfully' }
    else
      render json: { error: data_record.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def data_record_params
    params.require(:data_record).permit(:name, :data)
  end

 # def notify_webhooks(data_record)
 #   webhooks = Webhook.pluck(:url)
 #   webhooks.each do |webhook_url|
 #     response = HTTParty.post(webhook_url, body: webhook_payload(data_record).to_json, headers: { 'Content-Type' => 'application/json' })
 #     Rails.logger.info("Webhook sent to #{webhook_url}. Response: #{response.body}")
 #   end
 # end


def notify_webhooks(data_record)
  webhooks = Webhok.pluck(:url, :secret)    # pluck is a shortcut to select one or more attributes without loading the corresponding records just to filter out the selected attributes.
   
     
    webhooks.each do |webhook_url, secret|
    
      response = HTTParty.post(
        webhook_url,
        body: webhook_payload(data_record).to_json,
        headers: {
          'Content-Type' => 'application/json',
          'X-Webhook-Secret' => secret
        }
      )
       
      Rails.logger.info("Webhook sent to #{webhook_url}. Response: #{response.body}")
    end
  end







  def webhook_payload(data_record)
     
    {
      id: data_record.id,
      name: data_record.name,
      data: data_record.data
    }
  end
end

