/// Encoding mode.
const QRencodeMode = enum {
    QR_MODE_NUL, // Terminator (NUL character). Internal use only
    QR_MODE_NUM, // Numeric mode
    QR_MODE_AN, // Alphabet-numeric mode
    QR_MODE_8, // 8-bit data mode
    QR_MODE_KANJI, // Kanji (shift-jis) mode
    QR_MODE_STRUCTURE, // Internal use only
    QR_MODE_ECI, // ECI mode
    QR_MODE_FNC1FIRST, // FNC1, first position
    QR_MODE_FNC1SECOND, // FNC1, second position
};

/// Level of error correction.
const QRecLevel = enum {
    QR_ECLEVEL_L, // lowest
    QR_ECLEVEL_M,
    QR_ECLEVEL_Q,
    QR_ECLEVEL_H, // highest
};

/// Maximum version (size) of QR-code symbol.
const QRSPEC_VERSION_MAX: i32 = 40;
/// Maximum version (size) of QR-code symbol.
const MQRSPEC_VERSION_MAX: i32 = 4;

// QRcode class.
// Symbol data is represented as an array contains width*width uchars.
// Each uchar represents a module (dot). If the less significant bit of
// the uchar is 1, the corresponding module is black. The other bits are
// meaningless for usual applications, but here its specification is described.
//
// @verbatim
// MSB 76543210 LSB
//     |||||||`- 1=black/0=white
//     ||||||`-- 1=ecc/0=data code area
//     |||||`--- format information
//     ||||`---- version information
//     |||`----- timing pattern
//     ||`------ alignment pattern
//     |`------- finder pattern and separator
//     `-------- non-data modules (format, timing, etc.)
// @endverbatim
const QRCode = struct {
    version: i32, // version of the symbol
    width: i32, // width of the symbol
    data: []u8, // symbol data
};

const QRCodeList = struct {
    code: *QRCode,
    next: *QRCodeList, 
};

const QRInputList = struct {
    mode: QRencodeMode,
    data: []u8,
    input: *QRInputList,
};

const QRInput = struct {
    version: i32,
    level: QRecLevel,
    hint: i32,
    casesensitive: bool,
    binary: bool,
    data: []u8,
    input: *QRInput,
};

const QRMask = struct {
    mask: i32,
    func: i32,
};