require 'spec_helper'

RSpec.describe SafeContentPostGateway do
  #it "delegates #content_post_list" do
  #  gw = instance_spy('ContentPostGateway')
  #  sgw = SafeContentPostGateway.new(gw)
  #  sgw.content_post_list
  #  expect(gw).to have_received(:content_post_list)
  #end

  #it "pass arguments through #content_post_list" do
  #  gw = instance_spy('ContentPostGateway')
  #  sgw = SafeContentPostGateway.new(gw)
  #  arg1, arg2 = double('arg1'), double('arg2')
  #  sgw.content_post_list(arg1, arg2)
  #  expect(gw).to have_received(:content_post_list).with(arg1, arg2)
  #end

  DELEGATE_METHODS = %i[content_post_list find_content_post_by_id]
  DELEGATE_METHODS.each do |method_name|
    it "delegates ##{method_name}" do
      gw = instance_spy('ContentPostGateway')
      sgw = SafeContentPostGateway.new(gw)
      sgw.public_send(method_name)
      expect(gw).to have_received(method_name)
    end

    it "pass arguments through ##{method_name}" do
      gw = instance_spy('ContentPostGateway')
      sgw = SafeContentPostGateway.new(gw)
      arg1, arg2 = double('arg1'), double('arg2')
      sgw.public_send(method_name, arg1, arg2)
      expect(gw).to have_received(method_name).with(arg1, arg2)
    end

    it "passes on return values from ##{method_name}" do
      result = double('result')
      gw = instance_spy('ContentPostGateway',
                        method_name => result)
      sgw = SafeContentPostGateway.new(gw)
      expect(sgw.public_send(method_name)).to be result
    end

    it "prevents standard exceptions from exiting the ##{method_name}" do
      gw = instance_spy('ContentPostGateway')
      sgw = SafeContentPostGateway.new(gw)
      allow(gw).to receive(method_name).and_raise(StandardError)
      expect{ sgw.public_send(method_name) }.not_to raise_error
    end

    it "passes non-standard exceptions through from ##{method_name}" do
      gw = instance_spy('ContentPostGateway')
      sgw = SafeContentPostGateway.new(gw)
      allow(gw).to receive(method_name).and_raise(Exception)
      expect{ sgw.public_send(method_name) }.to raise_error
    end

    it "calls the :on_error handler on errors in ##{method_name}" do
      gw = instance_spy('ContentPostGateway')
      handler = double('handler', call: nil)
      sgw = SafeContentPostGateway.new(gw, on_error: handler)
      allow(gw).to receive(method_name).and_raise(StandardError)
      sgw.public_send(method_name)
      expect(handler).to have_received(:call)
    end

    it "calls error handler with error, method name, and args" do
      gw = instance_spy('ContentPostGateway')
      handler = double('handler', call: nil)
      arg1, arg2 = double('arg1'), double('arg2')
      error = StandardError.new('Whoopsie!')
      sgw = SafeContentPostGateway.new(gw, on_error: handler)
      allow(gw).to receive(method_name).and_raise(error)
      sgw.public_send(method_name, arg1, arg2)
      expect(handler).to have_received(:call).with(error, method_name, [arg1, arg2])
    end
  end

  it "returns an empty list on error from #content_post_list" do
    gw = instance_spy('ContentPostGateway')
    sgw = SafeContentPostGateway.new(gw)
    allow(gw).to receive(:content_post_list).and_raise(StandardError)
    expect(sgw.content_post_list).to eq []
  end

  it "returns an safe hash on error from #find_content_post_by_id" do
    gw = instance_spy('ContentPostGateway')
    sgw = SafeContentPostGateway.new(gw)
    allow(gw).to receive(:find_content_post_by_id).and_raise(StandardError)
    expected_keys = {
      content: "<Episode content unavailable>",
      synopis: "<Synopsis unavailable>"
    }
    expect(sgw.find_content_post_by_id).to match(hash_including(expected_keys))
  end
end

