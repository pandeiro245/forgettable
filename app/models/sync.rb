class Sync
  def initialize
    @k = KintoneSync::Kintone.new(ENV['KINTONE_APP_SYNC'])
    @ignore_types = ["RECORD_NUMBER", "MODIFIER", "CREATOR", "__REVISION__", "UPDATED_TIME", "CREATED_TIME", "__ID__"]
    @rand_nums = []
    @without_masking_types = ['DATE', 'DATETIME', 'CHECK_BOX']
  end

  def do(id)
    data = {}
    item = @k.find(id)

    @without_masking_fields = item['without_masking_fields']['value'].split(',')

    from_id = item['production_app_id']['value']
    to_id   = item['dev_app_id']['value']
    from = KintoneSync::Kintone.new(from_id)
    to   = KintoneSync::Kintone.new(to_id)

    if item['lookup_field_names']['value'].present?
      item['lookup_field_names']['value'].split(',').each do |keyval|
        key, val = keyval.split(':')
        data[key] = {}
        KintoneSync::Kintone.new(val).all.each do |r|
          production_record_id = r['production_record_id']['value']
          dev_record_id = r['$id']['value']
          data[key][production_record_id] = dev_record_id
        end
      end
    end

    will_create_params = []
    from.all.each do |r|
      params = {}
      id = r['$id']['value']

      puts "check #{id}"

      r.each do |key, val|
        type = val['type']
        value = val['value']

        masked_val = nil

        next if @ignore_types.include?(val['type'])

        # puts key

        if data.keys.include?(key) # lookup
          masked_val = data[key][r[key]['value']]
        elsif @without_masking_fields.include?(key) || @without_masking_types.include?(type)
          masked_val = val['value']
        else
          case type
          when "LINK"
            masked_val = "https://example.cybozu.com/"
          when "SINGLE_LINE_TEXT"
            masked_val = "テスト#{key}#{id}"
          when "MULTI_LINE_TEXT"
            masked_val = ""
            3.times.each do |i|
              masked_val = "テスト#{key}#{id}\n"
            end
          when "DROP_DOWN"
            masked_val = val.present? ? val['value'] : nil
          when "NUMBER"
           masked_val = rand_num(val['value'])
          else
            raise val['type']
          end
        end
        params[key] = masked_val
      end

      params['production_record_id'] = id
      will_create_params.push(params)
    end

    to.create_all!(will_create_params)
  end

  def rand_num(num)
    return nil if num.blank?
    num = (rand * 10 ** num.to_s.length).to_i
    while @rand_nums.include?(num) do
      num = (rand * 10 ** num.to_s.length).to_i
    end
    @rand_nums.push(num)
    num
  end

  def all
    @k.all
  end
end

