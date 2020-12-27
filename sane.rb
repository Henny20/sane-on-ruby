
#include "sane.h"
#include "saneopts.h"
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
           :cap, :int,
           :constraint_type, :int,
           :constraint, SANE_Option_Descriptor_constraint
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
  SANE_NAME_NUM_OPTIONS = 
  SANE_NAME_STANDARD = standard
  SANE_NAME_GEOMETRY = geometry
  SANE_NAME_ENHANCEMENT = enhancement
  SANE_NAME_ADVANCED = advanced
  SANE_NAME_SENSORS = sensors
  SANE_NAME_PREVIEW = preview
  SANE_NAME_GRAY_PREVIEW = preview-in-gray
  SANE_NAME_BIT_DEPTH = depth
  SANE_NAME_SCAN_MODE = mode
  SANE_NAME_SCAN_SPEED = speed
  SANE_NAME_SCAN_SOURCE = source
  SANE_NAME_BACKTRACK = backtrack
  SANE_NAME_SCAN_TL_X = tl-x
  SANE_NAME_SCAN_TL_Y = tl-y
  SANE_NAME_SCAN_BR_X = br-x
  SANE_NAME_SCAN_BR_Y = br-y
  SANE_NAME_SCAN_RESOLUTION = resolution
  SANE_NAME_SCAN_X_RESOLUTION = x-resolution
  SANE_NAME_SCAN_Y_RESOLUTION = y-resolution
  SANE_NAME_PAGE_WIDTH = page-width
  SANE_NAME_PAGE_HEIGHT = page-height
  SANE_NAME_CUSTOM_GAMMA = custom-gamma
  SANE_NAME_GAMMA_VECTOR = gamma-table
  SANE_NAME_GAMMA_VECTOR_R = red-gamma-table
  SANE_NAME_GAMMA_VECTOR_G = green-gamma-table
  SANE_NAME_GAMMA_VECTOR_B = blue-gamma-table
  SANE_NAME_BRIGHTNESS = brightness
  SANE_NAME_CONTRAST = contrast
  SANE_NAME_GRAIN_SIZE = grain
  SANE_NAME_HALFTONE = halftoning
  SANE_NAME_BLACK_LEVEL = black-level
  SANE_NAME_WHITE_LEVEL = white-level
  SANE_NAME_WHITE_LEVEL_R = white-level-r
  SANE_NAME_WHITE_LEVEL_G = white-level-g
  SANE_NAME_WHITE_LEVEL_B = white-level-b
  SANE_NAME_SHADOW = shadow
  SANE_NAME_SHADOW_R = shadow-r
  SANE_NAME_SHADOW_G = shadow-g
  SANE_NAME_SHADOW_B = shadow-b
  SANE_NAME_HIGHLIGHT = highlight
  SANE_NAME_HIGHLIGHT_R = highlight-r
  SANE_NAME_HIGHLIGHT_G = highlight-g
  SANE_NAME_HIGHLIGHT_B = highlight-b
  SANE_NAME_HUE = hue
  SANE_NAME_SATURATION = saturation
  SANE_NAME_FILE = filename
  SANE_NAME_HALFTONE_DIMENSION = halftone-size
  SANE_NAME_HALFTONE_PATTERN = halftone-pattern
  SANE_NAME_RESOLUTION_BIND = resolution-bind
  SANE_NAME_NEGATIVE = negative
  SANE_NAME_QUALITY_CAL = quality-cal
  SANE_NAME_DOR = double-res
  SANE_NAME_RGB_BIND = rgb-bind
  SANE_NAME_THRESHOLD = threshold
  SANE_NAME_ANALOG_GAMMA = analog-gamma
  SANE_NAME_ANALOG_GAMMA_R = analog-gamma-r
  SANE_NAME_ANALOG_GAMMA_G = analog-gamma-g
  SANE_NAME_ANALOG_GAMMA_B = analog-gamma-b
  SANE_NAME_ANALOG_GAMMA_BIND = analog-gamma-bind
  SANE_NAME_WARMUP = warmup
  SANE_NAME_CAL_EXPOS_TIME = cal-exposure-time
  SANE_NAME_CAL_EXPOS_TIME_R = cal-exposure-time-r
  SANE_NAME_CAL_EXPOS_TIME_G = cal-exposure-time-g
  SANE_NAME_CAL_EXPOS_TIME_B = cal-exposure-time-b
  SANE_NAME_SCAN_EXPOS_TIME = scan-exposure-time
  SANE_NAME_SCAN_EXPOS_TIME_R = scan-exposure-time-r
  SANE_NAME_SCAN_EXPOS_TIME_G = scan-exposure-time-g
  SANE_NAME_SCAN_EXPOS_TIME_B = scan-exposure-time-b
  SANE_NAME_SELECT_EXPOSURE_TIME = select-exposure-time
  SANE_NAME_CAL_LAMP_DEN = cal-lamp-density
  SANE_NAME_SCAN_LAMP_DEN = scan-lamp-density
  SANE_NAME_SELECT_LAMP_DENSITY = select-lamp-density
  SANE_NAME_LAMP_OFF_AT_EXIT = lamp-off-at-exit
  SANE_NAME_SCAN = scan
  SANE_NAME_EMAIL = email
  SANE_NAME_FAX = fax
  SANE_NAME_COPY = copy
  SANE_NAME_PDF = pdf
  SANE_NAME_CANCEL = cancel
  SANE_NAME_PAGE_LOADED = page-loaded
  SANE_NAME_COVER_OPEN = cover-open
  SANE_TITLE_NUM_OPTIONS = Number of options
  SANE_TITLE_STANDARD = Standard
  SANE_TITLE_GEOMETRY = Geometry
  SANE_TITLE_ENHANCEMENT = Enhancement
  SANE_TITLE_ADVANCED = Advanced
  SANE_TITLE_SENSORS = Sensors
  SANE_TITLE_PREVIEW = Preview
  SANE_TITLE_GRAY_PREVIEW = Force monochrome preview
  SANE_TITLE_BIT_DEPTH = Bit depth
  SANE_TITLE_SCAN_MODE = Scan mode
  SANE_TITLE_SCAN_SPEED = Scan speed
  SANE_TITLE_SCAN_SOURCE = Scan source
  SANE_TITLE_BACKTRACK = Force backtracking
  SANE_TITLE_SCAN_TL_X = Top-left x
  SANE_TITLE_SCAN_TL_Y = Top-left y
  SANE_TITLE_SCAN_BR_X = Bottom-right x
  SANE_TITLE_SCAN_BR_Y = Bottom-right y
  SANE_TITLE_SCAN_RESOLUTION = Scan resolution
  SANE_TITLE_SCAN_X_RESOLUTION = X-resolution
  SANE_TITLE_SCAN_Y_RESOLUTION = Y-resolution
  SANE_TITLE_PAGE_WIDTH = Page width
  SANE_TITLE_PAGE_HEIGHT = Page height
  SANE_TITLE_CUSTOM_GAMMA = Use custom gamma table
  SANE_TITLE_GAMMA_VECTOR = Image intensity
  SANE_TITLE_GAMMA_VECTOR_R = Red intensity
  SANE_TITLE_GAMMA_VECTOR_G = Green intensity
  SANE_TITLE_GAMMA_VECTOR_B = Blue intensity
  SANE_TITLE_BRIGHTNESS = Brightness
  SANE_TITLE_CONTRAST = Contrast
  SANE_TITLE_GRAIN_SIZE = Grain size
  SANE_TITLE_HALFTONE = Halftoning
  SANE_TITLE_BLACK_LEVEL = Black level
  SANE_TITLE_WHITE_LEVEL = White level
  SANE_TITLE_WHITE_LEVEL_R = White level for red
  SANE_TITLE_WHITE_LEVEL_G = White level for green
  SANE_TITLE_WHITE_LEVEL_B = White level for blue
  SANE_TITLE_SHADOW = Shadow
  SANE_TITLE_SHADOW_R = Shadow for red
  SANE_TITLE_SHADOW_G = Shadow for green
  SANE_TITLE_SHADOW_B = Shadow for blue
  SANE_TITLE_HIGHLIGHT = Highlight
  SANE_TITLE_HIGHLIGHT_R = Highlight for red
  SANE_TITLE_HIGHLIGHT_G = Highlight for green
  SANE_TITLE_HIGHLIGHT_B = Highlight for blue
  SANE_TITLE_HUE = Hue
  SANE_TITLE_SATURATION = Saturation
  SANE_TITLE_FILE = Filename
  SANE_TITLE_HALFTONE_DIMENSION = Halftone pattern size
  SANE_TITLE_HALFTONE_PATTERN = Halftone pattern
  SANE_TITLE_RESOLUTION_BIND = Bind X and Y resolution
  SANE_TITLE_NEGATIVE = Negative
  SANE_TITLE_QUALITY_CAL = Quality calibration
  SANE_TITLE_DOR = Double Optical Resolution
  SANE_TITLE_RGB_BIND = Bind RGB
  SANE_TITLE_THRESHOLD = Threshold
  SANE_TITLE_ANALOG_GAMMA = Analog gamma correction
  SANE_TITLE_ANALOG_GAMMA_R = Analog gamma red
  SANE_TITLE_ANALOG_GAMMA_G = Analog gamma green
  SANE_TITLE_ANALOG_GAMMA_B = Analog gamma blue
  SANE_TITLE_ANALOG_GAMMA_BIND = Bind analog gamma
  SANE_TITLE_WARMUP = Warmup lamp
  SANE_TITLE_CAL_EXPOS_TIME = Cal. exposure-time
  SANE_TITLE_CAL_EXPOS_TIME_R = Cal. exposure-time for red
  SANE_TITLE_CAL_EXPOS_TIME_G = Cal. exposure-time for green
  SANE_TITLE_CAL_EXPOS_TIME_B = Cal. exposure-time for blue
  SANE_TITLE_SCAN_EXPOS_TIME = Scan exposure-time
  SANE_TITLE_SCAN_EXPOS_TIME_R = Scan exposure-time for red
  SANE_TITLE_SCAN_EXPOS_TIME_G = Scan exposure-time for green
  SANE_TITLE_SCAN_EXPOS_TIME_B = Scan exposure-time for blue
  SANE_TITLE_SELECT_EXPOSURE_TIME = Set exposure-time
  SANE_TITLE_CAL_LAMP_DEN = Cal. lamp density
  SANE_TITLE_SCAN_LAMP_DEN = Scan lamp density
  SANE_TITLE_SELECT_LAMP_DENSITY = Set lamp density
  SANE_TITLE_LAMP_OFF_AT_EXIT = Lamp off at exit
  SANE_TITLE_SCAN = Scan button
  SANE_TITLE_EMAIL = Email button
  SANE_TITLE_FAX = Fax button
  SANE_TITLE_COPY = Copy button
  SANE_TITLE_PDF = PDF button
  SANE_TITLE_CANCEL = Cancel button
  SANE_TITLE_PAGE_LOADED = Page loaded
  SANE_TITLE_COVER_OPEN = Cover open
  SANE_DESC_NUM_OPTIONS = Read-only option that specifies how many options a specific devices supports.
  SANE_DESC_STANDARD = Source, mode and resolution options
  SANE_DESC_GEOMETRY = Scan area and media size options
  SANE_DESC_ENHANCEMENT = Image modification options
  SANE_DESC_ADVANCED = Hardware specific options
  SANE_DESC_SENSORS = Scanner sensors and buttons
  SANE_DESC_PREVIEW = Request a preview-quality scan.
  SANE_DESC_GRAY_PREVIEW = Request that all previews are done in monochrome mode.  On a three-pass scanner this cuts down the number of passes to one and on a one-pass scanner, it reduces the memory requirements and scan-time of the preview.
  SANE_DESC_BIT_DEPTH = Number of bits per sample, typical values are 1 for "line-art" and 8 for multibit scans.
  SANE_DESC_SCAN_MODE = Selects the scan mode (e.g., lineart, monochrome, or color).
  SANE_DESC_SCAN_SPEED = Determines the speed at which the scan proceeds.
  SANE_DESC_SCAN_SOURCE = Selects the scan source (such as a document-feeder).
  SANE_DESC_BACKTRACK = Controls whether backtracking is forced.
  SANE_DESC_SCAN_TL_X = Top-left x position of scan area.
  SANE_DESC_SCAN_TL_Y = Top-left y position of scan area.
  SANE_DESC_SCAN_BR_X = Bottom-right x position of scan area.
  SANE_DESC_SCAN_BR_Y = Bottom-right y position of scan area.
  SANE_DESC_SCAN_RESOLUTION = Sets the resolution of the scanned image.
  SANE_DESC_SCAN_X_RESOLUTION = Sets the horizontal resolution of the scanned image.
  SANE_DESC_SCAN_Y_RESOLUTION = Sets the vertical resolution of the scanned image.
  SANE_DESC_PAGE_WIDTH = Specifies the width of the media.  Required for automatic centering of sheet-fed scans.
  SANE_DESC_PAGE_HEIGHT = Specifies the height of the media.
  SANE_DESC_CUSTOM_GAMMA = Determines whether a builtin or a custom gamma-table should be used.
  SANE_DESC_GAMMA_VECTOR = Gamma-correction table.  In color mode this option equally affects the red, green, and blue channels simultaneously (i.e., it is an intensity gamma table).
  SANE_DESC_GAMMA_VECTOR_R = Gamma-correction table for the red band.
  SANE_DESC_GAMMA_VECTOR_G = Gamma-correction table for the green band.
  SANE_DESC_GAMMA_VECTOR_B = Gamma-correction table for the blue band.
  SANE_DESC_BRIGHTNESS = Controls the brightness of the acquired image.
  SANE_DESC_CONTRAST = Controls the contrast of the acquired image.
  SANE_DESC_GRAIN_SIZE = Selects the "graininess" of the acquired image.  Smaller values result in sharper images.
  SANE_DESC_HALFTONE = Selects whether the acquired image should be halftoned (dithered).
  SANE_DESC_BLACK_LEVEL = Selects what radiance level should be considered "black".
  SANE_DESC_WHITE_LEVEL = Selects what radiance level should be considered "white".
  SANE_DESC_WHITE_LEVEL_R = Selects what red radiance level should be considered "white".
  SANE_DESC_WHITE_LEVEL_G = Selects what green radiance level should be considered "white".
  SANE_DESC_WHITE_LEVEL_B = Selects what blue radiance level should be considered "white".
  SANE_DESC_SHADOW = Selects what radiance level should be considered "black".
  SANE_DESC_SHADOW_R = Selects what red radiance level should be considered "black".
  SANE_DESC_SHADOW_G = Selects what green radiance level should be considered "black".
  SANE_DESC_SHADOW_B = Selects what blue radiance level should be considered "black".
  SANE_DESC_HIGHLIGHT = Selects what radiance level should be considered "white".
  SANE_DESC_HIGHLIGHT_R = Selects what red radiance level should be considered "full red".
  SANE_DESC_HIGHLIGHT_G = Selects what green radiance level should be considered "full green".
  SANE_DESC_HIGHLIGHT_B = Selects what blue radiance level should be considered "full blue".
  SANE_DESC_HUE = Controls the "hue" (blue-level) of the acquired image.
  SANE_DESC_SATURATION = The saturation level controls the amount of "blooming" that occurs when acquiring an image with a camera. Larger values cause more blooming.
  SANE_DESC_FILE = The filename of the image to be loaded.
  SANE_DESC_HALFTONE_DIMENSION = Sets the size of the halftoning (dithering) pattern used when scanning halftoned images.
  SANE_DESC_HALFTONE_PATTERN = Defines the halftoning (dithering) pattern for scanning halftoned images.
  SANE_DESC_RESOLUTION_BIND = Use same values for X and Y resolution
  SANE_DESC_NEGATIVE = Swap black and white
  SANE_DESC_QUALITY_CAL = Do a quality white-calibration
  SANE_DESC_DOR = Use lens that doubles optical resolution
  SANE_DESC_RGB_BIND = In RGB-mode use same values for each color
  SANE_DESC_THRESHOLD = Select minimum-brightness to get a white point
  SANE_DESC_ANALOG_GAMMA = Analog gamma-correction
  SANE_DESC_ANALOG_GAMMA_R = Analog gamma-correction for red
  SANE_DESC_ANALOG_GAMMA_G = Analog gamma-correction for green
  SANE_DESC_ANALOG_GAMMA_B = Analog gamma-correction for blue
  SANE_DESC_ANALOG_GAMMA_BIND = In RGB-mode use same values for each color
  SANE_DESC_WARMUP = Warmup lamp before scanning
  SANE_DESC_CAL_EXPOS_TIME = Define exposure-time for calibration
  SANE_DESC_CAL_EXPOS_TIME_R = Define exposure-time for red calibration
  SANE_DESC_CAL_EXPOS_TIME_G = Define exposure-time for green calibration
  SANE_DESC_CAL_EXPOS_TIME_B = Define exposure-time for blue calibration
  SANE_DESC_SCAN_EXPOS_TIME = Define exposure-time for scan
  SANE_DESC_SCAN_EXPOS_TIME_R = Define exposure-time for red scan
  SANE_DESC_SCAN_EXPOS_TIME_G = Define exposure-time for green scan
  SANE_DESC_SCAN_EXPOS_TIME_B = Define exposure-time for blue scan
  SANE_DESC_SELECT_EXPOSURE_TIME = Enable selection of exposure-time
  SANE_DESC_CAL_LAMP_DEN = Define lamp density for calibration
  SANE_DESC_SCAN_LAMP_DEN = Define lamp density for scan
  SANE_DESC_SELECT_LAMP_DENSITY = Enable selection of lamp density
  SANE_DESC_LAMP_OFF_AT_EXIT = Turn off lamp when program exits
  SANE_DESC_SCAN = Scan button
  SANE_DESC_EMAIL = Email button
  SANE_DESC_FAX = Fax button
  SANE_DESC_COPY = Copy button
  SANE_DESC_PDF = PDF button
  SANE_DESC_CANCEL = Cancel button
  SANE_DESC_PAGE_LOADED = Page loaded
  SANE_DESC_COVER_OPEN = Cover open
  SANE_VALUE_SCAN_MODE_COLOR = Color
  SANE_VALUE_SCAN_MODE_COLOR_LINEART = Color Lineart
  SANE_VALUE_SCAN_MODE_COLOR_HALFTONE = Color Halftone
  SANE_VALUE_SCAN_MODE_GRAY = Gray
  SANE_VALUE_SCAN_MODE_HALFTONE = Halftone
  SANE_VALUE_SCAN_MODE_LINEART = Lineart
