# coding: utf-8

module Fluent
  class Load < Input
    Plugin.register_input('regexpload', self)

    def initialize
      super
      require "randexp"
      require "erb"
    end

    config_param :repeats, :integer, :default => 0 # <=0 inf
    config_param :emit_interval, :float, :default => 1.0
    config_param :json_regexp_rand_seed, :string
    config_param :tag, :string

    class TimerWatcher < Coolio::TimerWatcher
      def initialize(interval, repeat, rp, &callback)
        @callback = callback
        super(interval, repeat)
        @rp = rp
      end

      def on_timer
        @rp = @rp - 1
        return if @rp < 0
        @callback.call
      rescue
        # TODO log?
        $log.error $!.to_s
        $log.error_backtrace
      end
    end

    def configure(conf)
      super
      if jrrs = conf["json_regexp_rand_seed"]
        @json_regexp_rand_seed = Regexp.compile(jrrs)
        @parser = TextParser::JSONParser.new
      end
    end

    def start
      return if @repeats <= 0
      @loop = Coolio::Loop.new
      @timer = TimerWatcher.new(@emit_interval, true, @repeats, &method(:on_timer))
      @loop.attach(@timer)
      @thread = Thread.new(&method(:run))
    end

    def shutdown
      @loop.watchers.each {|w| w.detach }
      @loop.stop
      @thread.join
    end

    def run
      @loop.run
    rescue
      $log.error "unexpected error", :error=>$!.to_s
      $log.error_backtrace
    end

    def on_timer
      now = Engine.now
      str = @json_regexp_rand_seed.gen
      record = ""
      if str =~ /\s*\{.*\}\s*/
        record = @parser.call(@json_regexp_rand_seed.gen)
      else
        record = str
      end
      Engine.emit(@tag, now, record)
    end
  end
end
