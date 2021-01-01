# frozen_string_literal: true

require 'ffi'

module Sane
  extend FFI::Library
  ffi_lib 'sane'
  SANE_CURRENT_MAJOR = 1
  SANE_CURRENT_MINOR = 0
  SANE_FALSE = 0
  SANE_TRUE = 1
  SANE_FIXED_SCALE_SHIFT = 16
  SANE_STATUS_GOOD = 0
  SANE_STATUS_UNSUPPORTED = 1
  SANE_STATUS_NO_MEM = 10
  SANE_STATUS_ACCESS_DENIED = 11
  SANE_STATUS_CANCELLED = 2
  SANE_STATUS_DEVICE_BUSY = 3
  SANE_STATUS_INVAL = 4
  SANE_STATUS_EOF = 5
  SANE_STATUS_JAMMED = 6
  SANE_STATUS_NO_DOCS = 7
  SANE_STATUS_COVER_OPEN = 8
  SANE_STATUS_IO_ERROR = 9

  enum :status, [:good, 0, :unsupported, :cancelled, :device_busy, :inval, :eof, :jammed, :no_docs, :cover_open, :io_error, :no_mem, :access_denied]
  enum :frame, [:gray, :rgb, :red, :green, :blue]

  SANE_TYPE_BOOL = 0
  SANE_TYPE_INT = 1
  SANE_TYPE_FIXED = 2
  SANE_TYPE_STRING = 3
  SANE_TYPE_BUTTON = 4
  SANE_TYPE_GROUP = 5

  SANE_UNIT_NONE = 0
  SANE_UNIT_PIXEL = 1
  SANE_UNIT_BIT = 2
  SANE_UNIT_MM = 3
  SANE_UNIT_DPI = 4
  SANE_UNIT_PERCENT = 5
  SANE_UNIT_MICROSECOND = 6

  class SANEDevice < FFI::Struct
    layout(
      :name, :pointer,
      :vendor, :pointer,
      :model, :pointer,
      :type, :pointer
    )
    def name=(str)
      @name = FFI::MemoryPointer.from_string(str)
      self[:name] = @name
    end

    def name
      @name.get_string(0)
    end

    def vendor=(str)
      @vendor = FFI::MemoryPointer.from_string(str)
      self[:vendor] = @vendor
    end

    def vendor
      @vendor.get_string(0)
    end

    def model=(str)
      @model = FFI::MemoryPointer.from_string(str)
      self[:model] = @model
    end

    def model
      @model.get_string(0)
    end

    def type=(str)
      @type = FFI::MemoryPointer.from_string(str)
      self[:type] = @type
    end

    def type
      @type.get_string(0)
    end

	def to_hash
      Hash[members.zip values.map(&:to_s)]
    end
  end
  SANE_CAP_SOFT_SELECT = (1 << 0)
  SANE_CAP_HARD_SELECT = (1 << 1)
  SANE_CAP_SOFT_DETECT = (1 << 2)
  SANE_CAP_EMULATED = (1 << 3)
  SANE_CAP_AUTOMATIC = (1 << 4)
  SANE_CAP_INACTIVE = (1 << 5)
  SANE_CAP_ADVANCED = (1 << 6)
  SANE_INFO_INEXACT = (1 << 0)
  SANE_INFO_RELOAD_OPTIONS = (1 << 1)
  SANE_INFO_RELOAD_PARAMS = (1 << 2)
  SANE_CONSTRAINT_NONE = 0
  SANE_CONSTRAINT_RANGE = 1
  SANE_CONSTRAINT_WORD_LIST = 2
  SANE_CONSTRAINT_STRING_LIST = 3

  class SANERange < FFI::Struct
    layout(
      :min, :int,
      :max, :int,
      :quant, :int
    )
  end
  class SANEOptionDescriptor < FFI::Struct
    layout(
      :name, :pointer,
      :title, :pointer,
      :desc, :pointer,
      :type, :int,
      :unit, :int,
      :size, :int,
      :cap, :int
      #         :constraint_type, :int
      #           :constraint, SANE_Option_Descriptor_constraint
    )
    def name=(str)
      @name = FFI::MemoryPointer.from_string(str)
      self[:name] = @name
    end

    def name
      @name.get_string(0)
    end

    def title=(str)
      @title = FFI::MemoryPointer.from_string(str)
      self[:title] = @title
    end

    def title
      @title.get_string(0)
    end

    def desc=(str)
      @desc = FFI::MemoryPointer.from_string(str)
      self[:desc] = @desc
    end

    def desc
      @desc.get_string(0)
    end
  end
  class SANEOptionDescriptorConstraint < FFI::Union
    layout(
      :string_list, :pointer,
      :word_list, :pointer,
      :range, :pointer
    )
  end
  SANE_ACTION_GET_VALUE = 0
  SANE_ACTION_SET_VALUE = 1
  SANE_ACTION_SET_AUTO = 2

  SANE_FRAME_GRAY = 0
  SANE_FRAME_RGB = 1
  SANE_FRAME_RED = 2
  SANE_FRAME_GREEN = 3
  SANE_FRAME_BLUE = 4

  class SANEParameters < FFI::Struct
    layout(
      :format, :int,
      :last_frame, :int,
      :bytes_per_line, :int,
      :pixels_per_line, :int,
      :lines, :int,
      :depth, :int
    )
  end
	
  class Parameters < FFI::Struct
      layout :format, :frame, :last_frame, :int, :bytes_per_line, :int, :pixels_per_line, :int, :lines, :int, :depth, :int

      def to_hash
        {
          :format => self[:format],
          :last_frame => self[:last_frame],
          :bytes_per_line => self[:bytes_per_line],
          :pixels_per_line => self[:pixels_per_line],
          :lines => self[:lines],
          :depth => self[:depth]
        }
      end
  end
  SANE_MAX_USERNAME_LEN = 128
  SANE_MAX_PASSWORD_LEN = 128
  callback(:SANE_Auth_Callback, %i[string string string], :void)
  attach_function :sane_init, %i[pointer SANE_Auth_Callback], :int
  attach_function :sane_exit, [], :void
  attach_function :sane_get_devices, %i[pointer int], :int
  attach_function :sane_open, %i[string pointer], :int
  attach_function :sane_close, [:pointer], :void
  attach_function :sane_get_option_descriptor, %i[pointer int], :pointer
  attach_function :sane_control_option, %i[pointer int int pointer pointer], :int
  attach_function :sane_get_parameters, %i[pointer pointer], :int
  attach_function :sane_start, [:pointer], :int
  attach_function :sane_read, %i[pointer pointer int pointer], :int
  attach_function :sane_cancel, [:pointer], :void
  attach_function :sane_set_io_mode, %i[pointer int], :int
  attach_function :sane_get_select_fd, %i[pointer pointer], :int
  attach_function :sane_strstatus, [:int], :string

  class Error < StandardError
    attr_reader :status

    def initialize(message, status)
      super(message)
      @status = status
    end
  end

  def self.get_devices
    ensure_initialized!
    devices_pointer_pointer = FFI::MemoryPointer.new(:pointer)
    check_status!(Sane.sane_get_devices(devices_pointer_pointer, 0))
    devices_pointer = devices_pointer_pointer.read_pointer
    result = []
    until devices_pointer.read_pointer.null?
      result << SANEDevice.new(devices_pointer.read_pointer).to_hash
      puts Hash[*result.first]
      devices_pointer += FFI.type_size(:pointer)
    end
    result
  end

  def self.not_initialized?
    @version.nil?
  end

  def self.initialized?
    !not_initialized?
  end

  def self.init
    ensure_not_initialized!
    version_code = FFI::MemoryPointer.new(:int)
    check_status!(Sane.sane_init(version_code, FFI::Pointer::NULL))
    @version = version_code.read_int
    puts @version
  end

  def self.ensure_not_initialized!
    raise('SANE library is already initialized') if initialized?
  end

  def self.ensure_initialized!
    raise('SANE library is not initialized') if not_initialized?
  end

  def self.check_status!(status)
    raise(Error.new(strstatus(status), status)) unless status == 0
  end

  def self.strstatus(status)
    ensure_initialized!
    Sane.sane_strstatus(status)
  end

  def self.open(device_name)
    ensure_initialized!
    device_handle_pointer = FFI::MemoryPointer.new(:pointer)
    check_status!(Sane.sane_open(device_name, device_handle_pointer))
    device_handle_pointer.read_pointer
    end

  def self.start(handle)
    ensure_initialized!
    Sane.sane_start(handle)
  end

  def self.read(handle, size = 64 * 1024)
    ensure_initialized!
	data_pointer = FFI::MemoryPointer.new(:char, size)
    length_pointer = FFI::MemoryPointer.new(:int)
    check_status!(Sane.sane_read(handle, data_pointer, size, length_pointer))
    data_pointer.read_string(length_pointer.read_int)
  end

  def self.get_parameters(handle)
    ensure_initialized!
    parameters_pointer = FFI::MemoryPointer.new(Sane::Parameters.size)
    check_status!(Sane.sane_get_parameters(handle, parameters_pointer))
    Sane::Parameters.new(parameters_pointer).to_hash
  end
end

Sane.init
dev = Sane.open('plustek:libusb:005:018')
#Sane.get_devices
oops = Sane.get_parameters(dev)
puts oops
Sane.start(dev)
Sane.read(dev)
