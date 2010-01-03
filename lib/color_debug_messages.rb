require 'term/ansicolor'

# Include this module into your class to get access to the
# debug helper functions.
module ColorDebugMessages
  # if you specify nothing else, you get full-messages, nothing hidden
  DEFAULT_DEBUG_FLAGS = {
    :info        => true,
    :debug       => true,
    :warn        => true,
    :class_only  => false,
    :prefix_only => false
  }

  # You can change the option flags globally by setting this to a hash
  # of flags. For example, to only have 'info' and 'warn' level
  # messages, with only class names and no function names, you could do:
  #
  #     ColorDebugMessages.debug_flags = {
  #       :debug      => false,
  #       :class_only => true
  #     }
  #
  # The hash is merged with the existing one, so it is not necessary
  # to name things that are already set the way you want.
  def self.debug_flags=(opts)
    debug_flags.merge! opts
  end
  
  # returns the global flags
  def self.debug_flags
    @debug_flags ||= DEFAULT_DEBUG_FLAGS
  end
  
  # This is the same as ColorDebugMessages#debug_flags but on a
  # per-instance level, if you need to locally change things for some
  # reason. This hash starts out blank, and any missing entries are
  # looked up in the global hash.  
  def debug_flags=(opts)
    debug_flags.merge! opts
  end

  # returns the per-instance flag overrides
  def debug_flags
    @color_debug_message_options ||= Hash.new
  end
  
  # returns +true+ if the flag is true in either the local instance
  # or the global hash.
  def debug_flag_active?(name)
    if debug_flags.has_key?(name)
      debug_flags
    else
      ColorDebugMessages.debug_flags
    end[name]
  end
  
  # returns the prefix to tag on debug messages for a class.
  # This normally reflects the class name itself, and appends
  # the function name (caller[1]) of what cause this message.
  # It can be overridden in your class to whatever you want,
  # if necessary. Just return a string.
  def debug_message_prefix
    return self.class.to_s if debug_flag_active?(:class_only)

    name = self.class.to_s + '#'
    if /`(.*)'/ =~ caller[1]
      name + $1
    else
      name + "[unknown]"
    end
  end

  class ColorDebugMsg # :nodoc:all
    include Term::ANSIColor
    attr_reader :color, :mark, :calling_method_name, :msg
    
    def initialize(msg, prefix=nil, mark=nil, color=nil)
      @color  = color
      @mark   = mark
      @prefix = prefix
      @msg    = msg
    end

    def to_s
      str = ''
      if @prefix
        if @color
          str += send @color, bold('[')
          str += send @color, @prefix
          str += send @color, bold('] ')
        else
          str += "[#{@prefix}] "
        end
      end

      if @mark
        mark_str = @mark + @mark + '> '
        if @color
          str += send @color, bold(mark_str)
        else
          str += mark_str
        end
      end

      str += reset if @color
      str += @msg
    end
  end
  
  # returns a string with the ANSI *bold* flag set, for usage in
  # the middle of debug statements.
  #
  #     debug "This is a " + bold("fancy") + "message!"
  def bold(string_to_bold)
    Term::ANSIColor.bold string_to_bold
  end
  
  # Meta-generator for the actual debug message calls. At the core,
  # these are all just a fancy wrapper around Kernel#puts with
  # the color output. They always add the newline "\n" character to
  # the end as a convenience, and usually prefix the line with an
  # identifying mark, so we know what generated the message.
  #
  # === Options:
  # <tt>:name</tt>::        (Symbol) The name of the function to
  #                         create. Existing functions can be
  #                         overwritten to change their color/prefix.
  # <tt>:prefix_char</tt>:: (String) A character to use as a separator
  #                         for messages of this type.
  # <tt>:color</tt>::       (Symbol) The color to use for the
  #                         prefix. This must be a valid function in
  #                         the Term::ANSIColor library.
  def self.color_debug_message_type(name, prefix_char, color)
    define_method(name) do |msg|
      if debug_flag_active?(name)
        caller_prefix = debug_message_prefix
        caller_prefix = nil if debug_flag_active?(:prefix_only)
        puts ColorDebugMsg.new(msg, caller_prefix, prefix_char, color)
      end
    end
  end

  color_debug_message_type :debug, '>', :cyan
  color_debug_message_type :warn,  '*', :red
  color_debug_message_type :info,  '-', :green  
end
