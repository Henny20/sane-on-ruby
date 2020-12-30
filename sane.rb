
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
  SANE_MAX_USERNAME_LEN = 128
  SANE_MAX_PASSWORD_LEN = 128
  callback(:SANE_Auth_Callback, [ :string, :string, :string ], :void)
  attach_function :sane_init, [ :pointer, :SANE_Auth_Callback ], :int
  attach_function :sane_exit, [  ], :void
  attach_function :sane_get_devices, [ :pointer, :int ], :int
  attach_function :sane_open, [ :string, :pointer ], :int
  attach_function :sane_close, [ :pointer ], :void
  attach_function :sane_get_option_descriptor, [ :pointer, :int ], :pointer
  attach_function :sane_control_option, [ :pointer, :int, :int, :pointer, :pointer ], :int
  attach_function :sane_get_parameters, [ :pointer, :pointer ], :int
  attach_function :sane_start, [ :pointer ], :int
  attach_function :sane_read, [ :pointer, :pointer, :int, :pointer ], :int
  attach_function :sane_cancel, [ :pointer ], :void
  attach_function :sane_set_io_mode, [ :pointer, :int ], :int
  attach_function :sane_get_select_fd, [ :pointer, :pointer ], :int
  attach_function :sane_strstatus, [ :int ], :string

end

Sane.sane_init(0, 0)
