#include <gio/gio.h>

#if defined (__ELF__) && ( __GNUC__ > 2 || (__GNUC__ == 2 && __GNUC_MINOR__ >= 6))
# define SECTION __attribute__ ((section (".gresource.typebreaker_indicator"), aligned (8)))
#else
# define SECTION
#endif

static const SECTION union { const guint8 data[4081]; const double alignment; void * const ptr;}  typebreaker_indicator_resource_data = { {
  0x47, 0x56, 0x61, 0x72, 0x69, 0x61, 0x6e, 0x74, 
  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
  0x18, 0x00, 0x00, 0x00, 0xc8, 0x00, 0x00, 0x00, 
  0x00, 0x00, 0x00, 0x28, 0x06, 0x00, 0x00, 0x00, 
  0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 
  0x01, 0x00, 0x00, 0x00, 0x03, 0x00, 0x00, 0x00, 
  0x04, 0x00, 0x00, 0x00, 0x05, 0x00, 0x00, 0x00, 
  0x94, 0x5d, 0xdc, 0x97, 0x04, 0x00, 0x00, 0x00, 
  0xc8, 0x00, 0x00, 0x00, 0x07, 0x00, 0x4c, 0x00, 
  0xd0, 0x00, 0x00, 0x00, 0xd4, 0x00, 0x00, 0x00, 
  0x8c, 0x93, 0x8e, 0x95, 0x03, 0x00, 0x00, 0x00, 
  0xd4, 0x00, 0x00, 0x00, 0x16, 0x00, 0x4c, 0x00, 
  0xec, 0x00, 0x00, 0x00, 0xf0, 0x00, 0x00, 0x00, 
  0xd4, 0xb5, 0x02, 0x00, 0xff, 0xff, 0xff, 0xff, 
  0xf0, 0x00, 0x00, 0x00, 0x01, 0x00, 0x4c, 0x00, 
  0xf4, 0x00, 0x00, 0x00, 0xf8, 0x00, 0x00, 0x00, 
  0xd5, 0x74, 0x01, 0x6f, 0x00, 0x00, 0x00, 0x00, 
  0xf8, 0x00, 0x00, 0x00, 0x08, 0x00, 0x4c, 0x00, 
  0x00, 0x01, 0x00, 0x00, 0x04, 0x01, 0x00, 0x00, 
  0xc2, 0xaf, 0x89, 0x0b, 0x02, 0x00, 0x00, 0x00, 
  0x04, 0x01, 0x00, 0x00, 0x04, 0x00, 0x4c, 0x00, 
  0x08, 0x01, 0x00, 0x00, 0x0c, 0x01, 0x00, 0x00, 
  0x9d, 0x9e, 0x86, 0xa5, 0x01, 0x00, 0x00, 0x00, 
  0x0c, 0x01, 0x00, 0x00, 0x0f, 0x00, 0x76, 0x00, 
  0x20, 0x01, 0x00, 0x00, 0xf1, 0x0f, 0x00, 0x00, 
  0x67, 0x69, 0x74, 0x68, 0x75, 0x62, 0x2f, 0x00, 
  0x03, 0x00, 0x00, 0x00, 0x74, 0x79, 0x70, 0x65, 
  0x62, 0x72, 0x65, 0x61, 0x6b, 0x65, 0x72, 0x2d, 
  0x69, 0x6e, 0x64, 0x69, 0x63, 0x61, 0x74, 0x6f, 
  0x72, 0x2f, 0x00, 0x00, 0x05, 0x00, 0x00, 0x00, 
  0x2f, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 
  0x68, 0x61, 0x6e, 0x6e, 0x65, 0x6e, 0x7a, 0x2f, 
  0x01, 0x00, 0x00, 0x00, 0x63, 0x6f, 0x6d, 0x2f, 
  0x00, 0x00, 0x00, 0x00, 0x74, 0x79, 0x70, 0x65, 
  0x62, 0x72, 0x65, 0x61, 0x6b, 0x65, 0x72, 0x2e, 
  0x70, 0x6e, 0x67, 0x00, 0x00, 0x00, 0x00, 0x00, 
  0xc1, 0x0e, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
  0x89, 0x50, 0x4e, 0x47, 0x0d, 0x0a, 0x1a, 0x0a, 
  0x00, 0x00, 0x00, 0x0d, 0x49, 0x48, 0x44, 0x52, 
  0x00, 0x00, 0x00, 0x23, 0x00, 0x00, 0x00, 0x21, 
  0x08, 0x06, 0x00, 0x00, 0x00, 0x53, 0x11, 0x12, 
  0x52, 0x00, 0x00, 0x09, 0x29, 0x69, 0x43, 0x43, 
  0x50, 0x69, 0x63, 0x63, 0x00, 0x00, 0x78, 0xda, 
  0x95, 0x91, 0x67, 0x50, 0x94, 0x87, 0x16, 0x86, 
  0xcf, 0xf7, 0x7d, 0xdb, 0x0b, 0x6d, 0x97, 0xa5, 
  0xc3, 0xd2, 0x9b, 0x54, 0x29, 0x0b, 0x48, 0x59, 
  0x7a, 0x95, 0x5e, 0x45, 0x05, 0x96, 0xde, 0x59, 
  0x96, 0x22, 0x62, 0x43, 0xc4, 0x08, 0x44, 0x14, 
  0x11, 0x69, 0x8a, 0x20, 0xa2, 0x80, 0x82, 0x51, 
  0x29, 0x12, 0x2b, 0xa2, 0x58, 0x08, 0x0a, 0x8a, 
  0x58, 0xd0, 0x2c, 0x12, 0x04, 0x94, 0x18, 0x8c, 
  0x22, 0x2a, 0x28, 0xf7, 0x47, 0xee, 0x4c, 0x9c, 
  0x7b, 0x27, 0x3f, 0xf2, 0xfc, 0x7a, 0xe6, 0x9d, 
  0x77, 0xce, 0x39, 0x33, 0x07, 0x80, 0x22, 0x06, 
  0x00, 0x80, 0x8a, 0x01, 0xa4, 0xa4, 0x0a, 0xf8, 
  0x7e, 0x2e, 0xf6, 0xec, 0x90, 0xd0, 0x30, 0x36, 
  0x7c, 0x47, 0x24, 0x2f, 0x33, 0x9d, 0xeb, 0xe3, 
  0xe3, 0x09, 0xff, 0xc8, 0xc7, 0x51, 0x40, 0x00, 
  0x00, 0x1e, 0xac, 0x82, 0x7f, 0x0f, 0x25, 0x3a, 
  0x26, 0x93, 0x07, 0x00, 0xcb, 0x00, 0x90, 0xcf, 
  0x4b, 0xe7, 0x0b, 0x00, 0x90, 0x5c, 0x00, 0xd0, 
  0xca, 0x11, 0xa4, 0x0b, 0x00, 0x90, 0xa3, 0x00, 
  0xc0, 0x8c, 0x4a, 0x4a, 0x17, 0x00, 0x20, 0xe7, 
  0x01, 0x80, 0xc9, 0x0f, 0x09, 0x0d, 0x03, 0x40, 
  0x6e, 0x01, 0x00, 0x33, 0xee, 0x2f, 0x1f, 0x07, 
  0x00, 0x66, 0xd4, 0x5f, 0x3e, 0x0f, 0x00, 0x4c, 
  0x7e, 0x80, 0x9f, 0x03, 0x00, 0x8a, 0x03, 0x20, 
  0xd1, 0xe2, 0xbe, 0xf3, 0xa8, 0xef, 0xfc, 0xbf, 
  0x7b, 0x01, 0x00, 0x54, 0xb8, 0x7c, 0x41, 0x42, 
  0x6c, 0x4c, 0x2e, 0xdb, 0x3f, 0x2d, 0x56, 0x90, 
  0x13, 0xc9, 0x8f, 0x61, 0x67, 0xfa, 0xb9, 0xd8, 
  0xb3, 0xdd, 0x1c, 0x1c, 0xd8, 0x3e, 0xfc, 0xb4, 
  0xd8, 0x84, 0xe4, 0x98, 0xef, 0x0e, 0xfe, 0x57, 
  0xe5, 0x7f, 0x40, 0x10, 0x93, 0x2b, 0x00, 0x00, 
  0x70, 0x48, 0x4b, 0xdf, 0xc4, 0x4f, 0x88, 0x8b, 
  0x17, 0xb0, 0xff, 0x6f, 0xa8, 0xb1, 0xa1, 0x91, 
  0x11, 0xfc, 0xfd, 0x8b, 0xf7, 0xbe, 0x80, 0x00, 
  0x00, 0xc2, 0x1a, 0xfc, 0xdf, 0xff, 0x00, 0xc0, 
  0x77, 0xbd, 0xb4, 0x46, 0x00, 0xce, 0x02, 0x00, 
  0xb6, 0xef, 0xef, 0x2c, 0xaa, 0x1a, 0xa0, 0x7b, 
  0x17, 0x80, 0xf4, 0xd3, 0xbf, 0x33, 0xb5, 0xa3, 
  0x00, 0xa2, 0x85, 0x00, 0x5d, 0xf7, 0x78, 0x59, 
  0xfc, 0xec, 0xbf, 0x32, 0x1c, 0x00, 0x00, 0x1e, 
  0x28, 0x20, 0x0a, 0x4c, 0x90, 0x01, 0x45, 0x50, 
  0x05, 0x2d, 0xd0, 0x03, 0x63, 0x30, 0x07, 0x2b, 
  0xb0, 0x03, 0x27, 0x70, 0x07, 0x6f, 0x08, 0x80, 
  0x50, 0xd8, 0x00, 0x3c, 0x88, 0x87, 0x14, 0xe0, 
  0x43, 0x0e, 0xe4, 0xc3, 0x0e, 0x28, 0x82, 0x12, 
  0xd8, 0x07, 0x07, 0xa1, 0x06, 0xea, 0xa1, 0x09, 
  0x5a, 0xa0, 0x1d, 0xce, 0x42, 0x37, 0x5c, 0x84, 
  0x6b, 0x70, 0x13, 0xee, 0xc2, 0x7d, 0x18, 0x85, 
  0x67, 0x20, 0x84, 0x29, 0x78, 0x03, 0xf3, 0xf0, 
  0x11, 0x96, 0x10, 0x04, 0x21, 0x22, 0x74, 0x84, 
  0x81, 0xc8, 0x20, 0x4a, 0x88, 0x3a, 0xa2, 0x8b, 
  0x18, 0x23, 0x1c, 0xc4, 0x06, 0x71, 0x42, 0x3c, 
  0x11, 0x3f, 0x24, 0x14, 0x89, 0x40, 0xe2, 0x90, 
  0x54, 0x24, 0x0b, 0xc9, 0x47, 0x76, 0x22, 0x25, 
  0x48, 0x39, 0x52, 0x83, 0x34, 0x20, 0x2d, 0xc8, 
  0x4f, 0xc8, 0x05, 0xe4, 0x1a, 0x72, 0x1b, 0x19, 
  0x46, 0x9e, 0x20, 0x13, 0xc8, 0x2c, 0xf2, 0x27, 
  0xf2, 0x05, 0xc5, 0x50, 0x1a, 0xca, 0x44, 0x15, 
  0x50, 0x0d, 0xd4, 0x00, 0xe5, 0xa0, 0x5c, 0xd4, 
  0x03, 0x0d, 0x40, 0xd7, 0xa3, 0x71, 0x68, 0x06, 
  0x9a, 0x87, 0x16, 0xa2, 0x7b, 0xd1, 0x2a, 0xb4, 
  0x11, 0x3d, 0x85, 0x76, 0xa1, 0xd7, 0xd0, 0xbb, 
  0xe8, 0x28, 0x2a, 0x44, 0xdf, 0xa0, 0x0b, 0x18, 
  0x60, 0x54, 0x8c, 0x85, 0x29, 0x63, 0x7a, 0x18, 
  0x07, 0x73, 0xc0, 0xbc, 0xb1, 0x30, 0x2c, 0x16, 
  0xe3, 0x63, 0x5b, 0xb1, 0x62, 0xac, 0x12, 0x6b, 
  0xc4, 0xda, 0xb1, 0x5e, 0x6c, 0x00, 0x7b, 0x80, 
  0x09, 0xb1, 0x39, 0xec, 0x33, 0x8e, 0x80, 0x63, 
  0xe0, 0xd8, 0x38, 0x3d, 0x9c, 0x15, 0xce, 0x15, 
  0x17, 0x88, 0xe3, 0xe1, 0x32, 0x70, 0x5b, 0x71, 
  0xa5, 0xb8, 0x1a, 0xdc, 0x49, 0x5c, 0x17, 0xae, 
  0x1f, 0xf7, 0x00, 0x37, 0x81, 0x9b, 0xc7, 0x7d, 
  0xc3, 0xd3, 0xf1, 0xf2, 0x78, 0x5d, 0xbc, 0x25, 
  0xde, 0x0d, 0x1f, 0x82, 0x8f, 0xc3, 0xe7, 0xe0, 
  0x8b, 0xf0, 0x95, 0xf8, 0x66, 0x7c, 0x27, 0xfe, 
  0x06, 0x7e, 0x14, 0x3f, 0x85, 0xff, 0x48, 0x20, 
  0x10, 0x58, 0x04, 0x4d, 0x82, 0x39, 0xc1, 0x95, 
  0x10, 0x4a, 0x48, 0x24, 0x6c, 0x26, 0x94, 0x12, 
  0x0e, 0x13, 0x3a, 0x08, 0x57, 0x09, 0xc3, 0x84, 
  0x49, 0xc2, 0x02, 0x91, 0x48, 0x94, 0x21, 0xea, 
  0x12, 0xad, 0x89, 0xde, 0xc4, 0x48, 0xa2, 0x80, 
  0x58, 0x44, 0xac, 0x26, 0x9e, 0x22, 0x5e, 0x21, 
  0x8e, 0x10, 0xa7, 0x88, 0x9f, 0x48, 0x54, 0x92, 
  0x12, 0xc9, 0x98, 0xe4, 0x4c, 0x0a, 0x23, 0xa5, 
  0x92, 0x0a, 0x48, 0x95, 0xa4, 0x56, 0xd2, 0x65, 
  0xd2, 0x08, 0x69, 0x9a, 0xb4, 0x44, 0x16, 0x23, 
  0xab, 0x93, 0x2d, 0xc9, 0xde, 0xe4, 0x68, 0xf2, 
  0x26, 0x72, 0x19, 0xb9, 0x89, 0xdc, 0x4b, 0xbe, 
  0x47, 0x9e, 0x22, 0x2f, 0x51, 0xc4, 0x29, 0x9a, 
  0x14, 0x6b, 0x4a, 0x00, 0x25, 0x91, 0xb2, 0x83, 
  0x52, 0x45, 0x69, 0xa7, 0xdc, 0xa0, 0x8c, 0x53, 
  0xde, 0x53, 0xa9, 0x54, 0x15, 0xaa, 0x05, 0xd5, 
  0x97, 0x9a, 0x40, 0xdd, 0x4e, 0xad, 0xa2, 0x9e, 
  0xa1, 0xde, 0xa2, 0x4e, 0x50, 0x3f, 0xd3, 0x24, 
  0x68, 0x3a, 0x34, 0x07, 0x5a, 0x38, 0x2d, 0x8b, 
  0xb6, 0x97, 0x76, 0x82, 0x76, 0x95, 0xf6, 0x84, 
  0xf6, 0x9e, 0x4e, 0xa7, 0x6b, 0xd0, 0xed, 0xe8, 
  0x61, 0x74, 0x01, 0x7d, 0x2f, 0xbd, 0x85, 0x7e, 
  0x9d, 0xfe, 0x82, 0xfe, 0x49, 0x84, 0x21, 0xa2, 
  0x2f, 0xe2, 0x26, 0x12, 0x2d, 0xb2, 0x4d, 0xa4, 
  0x56, 0xa4, 0x4b, 0x64, 0x44, 0xe4, 0xad, 0x28, 
  0x59, 0x54, 0x5d, 0x94, 0x2b, 0xba, 0x41, 0x34, 
  0x4f, 0xb4, 0x52, 0xf4, 0x9c, 0xe8, 0x3d, 0xd1, 
  0x39, 0x31, 0xb2, 0x98, 0x86, 0x98, 0x83, 0x58, 
  0xa4, 0xd8, 0x56, 0xb1, 0x5a, 0xb1, 0x0b, 0x62, 
  0x63, 0x62, 0x0b, 0xe2, 0x0c, 0x71, 0x23, 0x71, 
  0x6f, 0xf1, 0x14, 0xf1, 0x52, 0xf1, 0x56, 0xf1, 
  0xdb, 0xe2, 0x33, 0x12, 0x44, 0x09, 0x0d, 0x09, 
  0x27, 0x89, 0x68, 0x89, 0x42, 0x89, 0x63, 0x12, 
  0xd7, 0x25, 0x26, 0x19, 0x18, 0x43, 0x95, 0xe1, 
  0xc0, 0xe0, 0x31, 0x76, 0x32, 0x9a, 0x18, 0x37, 
  0x18, 0x53, 0x4c, 0x02, 0x53, 0x93, 0xe9, 0xc6, 
  0x4c, 0x64, 0x96, 0x30, 0x4f, 0x33, 0x87, 0x98, 
  0xf3, 0x92, 0x12, 0x92, 0x26, 0x92, 0x41, 0x92, 
  0xb9, 0x92, 0xb5, 0x92, 0x97, 0x24, 0x85, 0x2c, 
  0x8c, 0xa5, 0xc1, 0x72, 0x63, 0x25, 0xb3, 0xca, 
  0x58, 0x67, 0x59, 0x8f, 0x58, 0x5f, 0xa4, 0x14, 
  0xa4, 0xb8, 0x52, 0x31, 0x52, 0x7b, 0xa4, 0xda, 
  0xa5, 0x46, 0xa4, 0x16, 0xa5, 0xe5, 0xa4, 0xed, 
  0xa4, 0x63, 0xa4, 0x8b, 0xa5, 0x3b, 0xa4, 0x47, 
  0xa5, 0xbf, 0xc8, 0xb0, 0x65, 0x9c, 0x64, 0x92, 
  0x64, 0xf6, 0xcb, 0x74, 0xcb, 0x3c, 0x97, 0xc5, 
  0xc9, 0xea, 0xc8, 0xfa, 0xca, 0xe6, 0xc8, 0x1e, 
  0x91, 0xbd, 0x21, 0x3b, 0x27, 0xc7, 0x94, 0xb3, 
  0x92, 0xe3, 0xc9, 0x15, 0xcb, 0x9d, 0x95, 0x7b, 
  0x2a, 0x8f, 0xca, 0xeb, 0xc8, 0xfb, 0xc9, 0x6f, 
  0x96, 0x3f, 0x26, 0x3f, 0x28, 0xbf, 0xa0, 0xa0, 
  0xa8, 0xe0, 0xa2, 0x90, 0xae, 0x50, 0xad, 0x70, 
  0x5d, 0x61, 0x4e, 0x91, 0xa5, 0x68, 0xa7, 0x98, 
  0xa8, 0x58, 0xa1, 0x78, 0x59, 0x71, 0x56, 0x89, 
  0xa1, 0x64, 0xa3, 0x94, 0xa0, 0x54, 0xa1, 0x74, 
  0x45, 0xe9, 0x35, 0x5b, 0x92, 0xcd, 0x65, 0x27, 
  0xb3, 0xab, 0xd8, 0xfd, 0xec, 0x79, 0x65, 0x79, 
  0x65, 0x57, 0xe5, 0x2c, 0xe5, 0x06, 0xe5, 0x21, 
  0xe5, 0x25, 0x15, 0x4d, 0x95, 0x40, 0x95, 0x02, 
  0x95, 0x0e, 0x95, 0xe7, 0xaa, 0x14, 0x55, 0x8e, 
  0x6a, 0xac, 0x6a, 0x85, 0x6a, 0x9f, 0xea, 0xbc, 
  0x9a, 0x92, 0x9a, 0x97, 0x5a, 0xbe, 0x5a, 0x9b, 
  0xda, 0x53, 0x75, 0xb2, 0x3a, 0x47, 0x3d, 0x5e, 
  0xfd, 0x90, 0xfa, 0x80, 0xfa, 0xa2, 0x86, 0xa6, 
  0x46, 0xb0, 0xc6, 0x6e, 0x8d, 0x6e, 0x8d, 0x19, 
  0x4d, 0x69, 0x4d, 0x37, 0xcd, 0x3c, 0xcd, 0x36, 
  0xcd, 0x71, 0x2d, 0xba, 0x96, 0xad, 0x56, 0x86, 
  0x56, 0xa3, 0xd6, 0x43, 0x6d, 0x82, 0x36, 0x47, 
  0x3b, 0x49, 0xfb, 0xb0, 0xf6, 0x7d, 0x1d, 0x54, 
  0xc7, 0x54, 0x27, 0x5e, 0xa7, 0x56, 0xe7, 0x9e, 
  0x2e, 0xaa, 0x6b, 0xa6, 0x9b, 0xa0, 0x7b, 0x58, 
  0x77, 0x78, 0x15, 0x7e, 0x95, 0xc5, 0xaa, 0xd4, 
  0x55, 0x8d, 0xab, 0xc6, 0xf4, 0x68, 0x7a, 0x5c, 
  0xbd, 0x6c, 0xbd, 0x36, 0xbd, 0x09, 0x7d, 0x96, 
  0xbe, 0xa7, 0x7e, 0x81, 0x7e, 0xb7, 0xfe, 0x5b, 
  0x03, 0x35, 0x83, 0x30, 0x83, 0xfd, 0x06, 0x03, 
  0x06, 0xdf, 0x0c, 0x4d, 0x0d, 0x93, 0x0d, 0x9b, 
  0x0c, 0x9f, 0x19, 0x49, 0x18, 0xb9, 0x1b, 0x15, 
  0x18, 0xf5, 0x1a, 0xfd, 0x69, 0xac, 0x63, 0xcc, 
  0x33, 0xae, 0x35, 0x7e, 0xb8, 0x9a, 0xbe, 0xda, 
  0x79, 0xf5, 0xb6, 0xd5, 0x3d, 0xab, 0xdf, 0x99, 
  0xe8, 0x9a, 0xc4, 0x98, 0x1c, 0x31, 0x79, 0x6c, 
  0xca, 0x30, 0xf5, 0x32, 0xdd, 0x6d, 0xda, 0x67, 
  0xfa, 0xd5, 0xcc, 0xdc, 0x8c, 0x6f, 0xd6, 0x6e, 
  0x36, 0x6b, 0xae, 0x66, 0x1e, 0x61, 0x5e, 0x67, 
  0x3e, 0xc6, 0x61, 0x72, 0x7c, 0x38, 0xa5, 0x9c, 
  0x5b, 0x16, 0x78, 0x0b, 0x7b, 0x8b, 0x6d, 0x16, 
  0x17, 0x2d, 0x3e, 0x5b, 0x9a, 0x59, 0x0a, 0x2c, 
  0xcf, 0x5a, 0xfe, 0x61, 0xa5, 0x67, 0x95, 0x64, 
  0xd5, 0x6a, 0x35, 0xb3, 0x46, 0x73, 0x4d, 0xcc, 
  0x9a, 0xa6, 0x35, 0x93, 0xd6, 0x2a, 0xd6, 0x91, 
  0xd6, 0x0d, 0xd6, 0x42, 0x1b, 0xb6, 0x4d, 0x84, 
  0xcd, 0x51, 0x1b, 0xa1, 0xad, 0xb2, 0x6d, 0xa4, 
  0x6d, 0xa3, 0xed, 0x4b, 0x3b, 0x55, 0xbb, 0x68, 
  0xbb, 0x66, 0xbb, 0x69, 0xae, 0x36, 0x37, 0x91, 
  0x7b, 0x8a, 0xfb, 0xd6, 0xde, 0xd0, 0x9e, 0x6f, 
  0xdf, 0x69, 0xbf, 0xe8, 0x60, 0xe9, 0xb0, 0xc5, 
  0xe1, 0xaa, 0x23, 0xe6, 0xe8, 0xe2, 0x58, 0xec, 
  0x38, 0xe4, 0x24, 0xe1, 0x14, 0xe8, 0x54, 0xe3, 
  0xf4, 0xc2, 0x59, 0xc5, 0x39, 0xce, 0xb9, 0xcd, 
  0x79, 0xde, 0xc5, 0xd4, 0x65, 0xb3, 0xcb, 0x55, 
  0x57, 0xbc, 0xab, 0x87, 0xeb, 0x7e, 0xd7, 0x31, 
  0x37, 0x05, 0x37, 0x9e, 0x5b, 0x8b, 0xdb, 0xbc, 
  0xbb, 0xb9, 0xfb, 0x16, 0xf7, 0x7e, 0x0f, 0x9a, 
  0x87, 0xbf, 0x47, 0x8d, 0xc7, 0x4b, 0x4f, 0x1d, 
  0x4f, 0xbe, 0x67, 0xaf, 0x17, 0xea, 0xe5, 0xee, 
  0x75, 0xc0, 0x6b, 0x7c, 0xad, 0xfa, 0xda, 0xd4, 
  0xb5, 0xdd, 0xde, 0xe0, 0xed, 0xe6, 0x7d, 0xc0, 
  0xfb, 0xb9, 0x8f, 0xa6, 0x4f, 0x86, 0xcf, 0xcf, 
  0xbe, 0x04, 0x5f, 0x1f, 0xdf, 0x5a, 0xdf, 0x57, 
  0x7e, 0x46, 0x7e, 0xf9, 0x7e, 0x03, 0xfe, 0x0c, 
  0xff, 0x8d, 0xfe, 0xad, 0xfe, 0x1f, 0x03, 0xec, 
  0x03, 0xca, 0x02, 0x9e, 0x05, 0x6a, 0x05, 0x66, 
  0x05, 0xf6, 0x05, 0x89, 0x06, 0x85, 0x07, 0xb5, 
  0x04, 0x2d, 0x06, 0x3b, 0x06, 0x97, 0x07, 0x0b, 
  0x43, 0x0c, 0x42, 0xb6, 0x84, 0xdc, 0x0d, 0x95, 
  0x0d, 0x4d, 0x08, 0xed, 0x09, 0x23, 0x86, 0x05, 
  0x85, 0x35, 0x87, 0x2d, 0xac, 0x73, 0x5a, 0x77, 
  0x70, 0xdd, 0x54, 0xb8, 0x69, 0x78, 0x51, 0xf8, 
  0xa3, 0xf5, 0x9a, 0xeb, 0x73, 0xd7, 0xdf, 0xde, 
  0x20, 0xbb, 0x21, 0x79, 0xc3, 0xa5, 0x8d, 0xa2, 
  0x1b, 0x23, 0x37, 0x9e, 0x8b, 0xc0, 0x47, 0x04, 
  0x47, 0xb4, 0x46, 0x2c, 0x47, 0x7a, 0x47, 0x36, 
  0x46, 0x2e, 0x44, 0xb9, 0x45, 0xd5, 0x45, 0xcd, 
  0xf3, 0x1c, 0x78, 0x87, 0x78, 0x6f, 0xa2, 0xed, 
  0xa2, 0x2b, 0xa2, 0x67, 0x63, 0xac, 0x63, 0xca, 
  0x63, 0xa6, 0x63, 0xad, 0x63, 0xcb, 0x63, 0x67, 
  0xe2, 0xac, 0xe3, 0x0e, 0xc4, 0xcd, 0xc6, 0xdb, 
  0xc6, 0x57, 0xc6, 0xcf, 0x25, 0x38, 0x24, 0xd4, 
  0x24, 0xbc, 0x4b, 0x74, 0x4d, 0xac, 0x4f, 0x5c, 
  0x4c, 0xf2, 0x4e, 0x3a, 0x91, 0xb4, 0x92, 0x1c, 
  0x9c, 0xdc, 0x91, 0x42, 0x4a, 0x89, 0x48, 0xb9, 
  0x90, 0x2a, 0x91, 0x9a, 0x94, 0xda, 0x9f, 0xa6, 
  0x98, 0x96, 0x9b, 0x36, 0x9c, 0xae, 0x9b, 0x5e, 
  0x94, 0x2e, 0xcc, 0xb0, 0xcc, 0x38, 0x98, 0x31, 
  0xcf, 0xf7, 0xe0, 0x37, 0x67, 0x22, 0x99, 0xeb, 
  0x33, 0x7b, 0x04, 0x4c, 0x41, 0xba, 0x60, 0x30, 
  0x4b, 0x2b, 0x6b, 0x57, 0xd6, 0x44, 0xb6, 0x4d, 
  0x76, 0x6d, 0xf6, 0xa7, 0x9c, 0xa0, 0x9c, 0x73, 
  0xb9, 0xe2, 0xb9, 0xa9, 0xb9, 0x83, 0x9b, 0x74, 
  0x36, 0xed, 0xd9, 0x34, 0x9d, 0xe7, 0x9c, 0x77, 
  0x7c, 0x33, 0x6e, 0x33, 0x6f, 0x73, 0x5f, 0xbe, 
  0x72, 0xfe, 0x8e, 0xfc, 0x89, 0x2d, 0xdc, 0x2d, 
  0x0d, 0x5b, 0x91, 0xad, 0x51, 0x5b, 0xfb, 0xb6, 
  0xa9, 0x6e, 0x2b, 0xdc, 0x36, 0xb5, 0xdd, 0x65, 
  0xfb, 0xc9, 0x1d, 0x94, 0x1d, 0x49, 0x3b, 0x7e, 
  0x29, 0x30, 0x2c, 0x28, 0x2f, 0xf8, 0xb0, 0x33, 
  0x78, 0x67, 0x6f, 0xa1, 0x42, 0xe1, 0xf6, 0xc2, 
  0xc9, 0x5d, 0x2e, 0xbb, 0xda, 0x8a, 0x44, 0x8a, 
  0xf8, 0x45, 0x63, 0xbb, 0xad, 0x76, 0xd7, 0xff, 
  0x80, 0xfb, 0x21, 0xe1, 0x87, 0xa1, 0x3d, 0xab, 
  0xf7, 0x54, 0xef, 0xf9, 0x56, 0x1c, 0x5d, 0x7c, 
  0xa7, 0xc4, 0xb0, 0xa4, 0xb2, 0x64, 0xb9, 0x94, 
  0x57, 0x7a, 0xe7, 0x47, 0xa3, 0x1f, 0xab, 0x7e, 
  0x5c, 0xd9, 0x1b, 0xbb, 0x77, 0xa8, 0xcc, 0xac, 
  0xec, 0xc8, 0x3e, 0xc2, 0xbe, 0xd4, 0x7d, 0x8f, 
  0xf6, 0xdb, 0xee, 0x3f, 0x59, 0x2e, 0x5e, 0x9e, 
  0x57, 0x3e, 0x79, 0xc0, 0xeb, 0x40, 0x57, 0x05, 
  0xbb, 0xa2, 0xb8, 0xe2, 0xc3, 0xc1, 0x8d, 0x07, 
  0x6f, 0x57, 0x9a, 0x54, 0xd6, 0x1f, 0xa2, 0x1c, 
  0xca, 0x3a, 0x24, 0xac, 0xf2, 0xac, 0xea, 0xa9, 
  0x56, 0xab, 0xde, 0x57, 0xbd, 0x5c, 0x13, 0x5f, 
  0x33, 0x5a, 0x6b, 0x5f, 0xdb, 0x51, 0x27, 0x5f, 
  0xb7, 0xa7, 0x6e, 0xf1, 0x70, 0xf4, 0xe1, 0x91, 
  0x23, 0x76, 0x47, 0xda, 0xeb, 0x15, 0xea, 0x4b, 
  0xea, 0xbf, 0x1c, 0x4d, 0x38, 0xfa, 0xb8, 0xc1, 
  0xa5, 0xa1, 0xab, 0x51, 0xa3, 0xb1, 0xf2, 0x18, 
  0xe1, 0x58, 0xf6, 0xb1, 0x57, 0x4d, 0x41, 0x4d, 
  0x03, 0xc7, 0x39, 0xc7, 0x5b, 0x9a, 0x65, 0x9b, 
  0x4b, 0x9a, 0xbf, 0x9e, 0x48, 0x3d, 0x21, 0x3c, 
  0xe9, 0x77, 0xb2, 0xbf, 0xc5, 0xbc, 0xa5, 0xa5, 
  0x55, 0xbe, 0xb5, 0xac, 0x0d, 0x6d, 0xcb, 0x6a, 
  0x9b, 0x3d, 0x15, 0x7e, 0xea, 0xfe, 0x69, 0xc7, 
  0xd3, 0x3d, 0xed, 0x7a, 0xed, 0x0d, 0x1d, 0xac, 
  0x8e, 0x92, 0x33, 0x70, 0x26, 0xeb, 0xcc, 0xeb, 
  0x9f, 0x22, 0x7e, 0x7a, 0x74, 0xd6, 0xe3, 0x6c, 
  0xdf, 0x39, 0xce, 0xb9, 0xf6, 0xf3, 0xea, 0xe7, 
  0xeb, 0x3a, 0x19, 0x9d, 0xc5, 0x5d, 0x48, 0xd7, 
  0xa6, 0xae, 0xf9, 0xee, 0xf8, 0x6e, 0x61, 0x4f, 
  0x68, 0xcf, 0xf0, 0x05, 0xf7, 0x0b, 0x7d, 0xbd, 
  0x56, 0xbd, 0x9d, 0x3f, 0xeb, 0xff, 0x7c, 0xe2, 
  0xa2, 0xf2, 0xc5, 0xda, 0x4b, 0x92, 0x97, 0xca, 
  0x2e, 0x53, 0x2e, 0x17, 0x5e, 0x5e, 0xb9, 0x92, 
  0x77, 0x65, 0xe1, 0x6a, 0xfa, 0xd5, 0xb9, 0x6b, 
  0x71, 0xd7, 0x26, 0xfb, 0x36, 0xf6, 0x3d, 0xbb, 
  0x1e, 0x72, 0xfd, 0x61, 0xbf, 0x6f, 0xff, 0xd0, 
  0x0d, 0x8f, 0x1b, 0xb7, 0x6e, 0x3a, 0xdf, 0xbc, 
  0x3e, 0xc0, 0x1d, 0xb8, 0x72, 0xcb, 0xfa, 0xd6, 
  0xc5, 0xdb, 0x96, 0xb7, 0x2f, 0xdc, 0xe1, 0xdc, 
  0xe9, 0xbe, 0x6b, 0x76, 0xb7, 0x6b, 0xd0, 0x74, 
  0xb0, 0xf3, 0x17, 0xd3, 0x5f, 0x3a, 0x87, 0xcc, 
  0x86, 0xba, 0xee, 0x99, 0xdf, 0xeb, 0xb9, 0x6f, 
  0x71, 0xbf, 0x77, 0x78, 0xcd, 0xf0, 0xe5, 0x11, 
  0xdb, 0x91, 0x6b, 0x0f, 0x1c, 0x1f, 0xdc, 0x7c, 
  0xe8, 0xf6, 0xf0, 0xee, 0xe8, 0xda, 0xd1, 0xe1, 
  0x47, 0x81, 0x8f, 0x1e, 0x8f, 0x85, 0x8f, 0x09, 
  0x1f, 0x47, 0x3f, 0x9e, 0x79, 0x92, 0xfc, 0xe4, 
  0xdd, 0xd3, 0xec, 0xa7, 0x4b, 0xcf, 0xb6, 0x8f, 
  0xe3, 0xc7, 0x8b, 0x9f, 0x8b, 0x3d, 0xaf, 0x7c, 
  0x21, 0xff, 0xa2, 0xf1, 0x57, 0xed, 0x5f, 0x3b, 
  0x84, 0x66, 0xc2, 0x4b, 0x13, 0x8e, 0x13, 0x83, 
  0x2f, 0xfd, 0x5f, 0x3e, 0x9b, 0xe4, 0x4d, 0xbe, 
  0xf9, 0x2d, 0xf3, 0xb7, 0xe5, 0xa9, 0xc2, 0x57, 
  0xf4, 0x57, 0x95, 0xd3, 0x4a, 0xd3, 0x2d, 0x33, 
  0xc6, 0x33, 0x17, 0x67, 0x9d, 0x67, 0xef, 0xbf, 
  0x5e, 0xf7, 0x7a, 0xea, 0x4d, 0xfa, 0x9b, 0xa5, 
  0xb9, 0xa2, 0xdf, 0xc5, 0x7f, 0xaf, 0x7b, 0xab, 
  0xf5, 0xf6, 0xfc, 0x1f, 0x76, 0x7f, 0x0c, 0xce, 
  0x87, 0xcc, 0x4f, 0xbd, 0xe3, 0xbf, 0x5b, 0xf9, 
  0xb3, 0xf4, 0xbd, 0xcc, 0xfb, 0x13, 0x1f, 0x4c, 
  0x3e, 0xf4, 0x2d, 0xf8, 0x2c, 0xbc, 0xf8, 0x98, 
  0xf2, 0x71, 0x69, 0xb1, 0xf8, 0x93, 0xcc, 0xa7, 
  0x93, 0x9f, 0x39, 0x9f, 0x07, 0xbe, 0x04, 0x7f, 
  0x99, 0x5e, 0xca, 0x59, 0x26, 0x2e, 0x57, 0x7d, 
  0xd5, 0xfe, 0xda, 0xfb, 0xcd, 0xe3, 0xdb, 0xf8, 
  0x4a, 0xca, 0xca, 0xca, 0x7f, 0x00, 0x2e, 0xa2, 
  0x90, 0xbc, 0x50, 0xa7, 0xee, 0xb1, 0x00, 0x00, 
  0x00, 0x20, 0x63, 0x48, 0x52, 0x4d, 0x00, 0x00, 
  0x7a, 0x26, 0x00, 0x00, 0x80, 0x84, 0x00, 0x00, 
  0xfa, 0x00, 0x00, 0x00, 0x80, 0xe8, 0x00, 0x00, 
  0x75, 0x30, 0x00, 0x00, 0xea, 0x60, 0x00, 0x00, 
  0x3a, 0x98, 0x00, 0x00, 0x17, 0x70, 0x9c, 0xba, 
  0x51, 0x3c, 0x00, 0x00, 0x00, 0x06, 0x62, 0x4b, 
  0x47, 0x44, 0x00, 0xff, 0x00, 0xff, 0x00, 0xff, 
  0xa0, 0xbd, 0xa7, 0x93, 0x00, 0x00, 0x00, 0x09, 
  0x70, 0x48, 0x59, 0x73, 0x00, 0x00, 0x00, 0x48, 
  0x00, 0x00, 0x00, 0x48, 0x00, 0x46, 0xc9, 0x6b, 
  0x3e, 0x00, 0x00, 0x00, 0x07, 0x74, 0x49, 0x4d, 
  0x45, 0x07, 0xe1, 0x08, 0x19, 0x0e, 0x25, 0x13, 
  0x6a, 0x7e, 0x8d, 0x60, 0x00, 0x00, 0x04, 0x3a, 
  0x49, 0x44, 0x41, 0x54, 0x58, 0xc3, 0xcd, 0x97, 
  0x3d, 0x6f, 0x1c, 0x45, 0x18, 0xc7, 0x7f, 0xb3, 
  0x3b, 0xb7, 0xb7, 0x67, 0x3b, 0xf2, 0xc5, 0x72, 
  0xa2, 0x60, 0x4b, 0x20, 0x10, 0x05, 0x96, 0xd2, 
  0x05, 0xc4, 0x07, 0x48, 0x03, 0x6d, 0xdc, 0xba, 
  0x71, 0x90, 0xf8, 0x02, 0x08, 0x0a, 0x3a, 0xaa, 
  0x08, 0x29, 0x05, 0x52, 0x44, 0xf8, 0x14, 0x47, 
  0x41, 0xe1, 0x48, 0x94, 0x44, 0x8a, 0x94, 0x86, 
  0x9a, 0x02, 0x43, 0x01, 0xc6, 0x2f, 0xe7, 0x8b, 
  0x13, 0x27, 0x3e, 0xdf, 0xee, 0xce, 0x3c, 0x0f, 
  0xc5, 0xbe, 0xdc, 0x8b, 0xcf, 0x77, 0xe7, 0x44, 
  0x4a, 0xf2, 0x48, 0xa3, 0x1d, 0xcd, 0xce, 0xcb, 
  0x6f, 0xfe, 0xcf, 0xf3, 0xcc, 0xce, 0x1a, 0x55, 
  0xe5, 0x6d, 0x31, 0xb3, 0xbe, 0xbe, 0xae, 0x2b, 
  0x2b, 0x2b, 0x17, 0x1e, 0xa8, 0xaa, 0x88, 0x08, 
  0xaa, 0x3a, 0x54, 0x1f, 0x6c, 0x3b, 0xaf, 0x7d, 
  0x5c, 0x5b, 0xab, 0xd5, 0xc2, 0x1e, 0x1e, 0x1e, 
  0x72, 0x72, 0x72, 0x72, 0x61, 0x88, 0xd1, 0xc9, 
  0xbd, 0xf7, 0x67, 0x16, 0x1a, 0x2c, 0xc0, 0x99, 
  0xb6, 0xb2, 0x5f, 0xa3, 0xd1, 0x00, 0xc0, 0x96, 
  0x8b, 0x5c, 0x6a, 0x34, 0x89, 0x6a, 0xd1, 0x44, 
  0x10, 0x51, 0x45, 0xcf, 0x80, 0x14, 0x6d, 0x2a, 
  0x03, 0xf5, 0x42, 0x19, 0x11, 0x7c, 0xd9, 0x57, 
  0x14, 0x51, 0x29, 0xc6, 0xe7, 0x75, 0xef, 0x1c, 
  0xfb, 0x47, 0xff, 0x55, 0xb0, 0x76, 0x70, 0xb1, 
  0x20, 0x0c, 0xcf, 0x93, 0x03, 0x11, 0xc1, 0x00, 
  0x0a, 0x18, 0x63, 0xc8, 0x43, 0xad, 0x88, 0x37, 
  0x03, 0xa8, 0xc1, 0xa0, 0xa8, 0x31, 0x98, 0x62, 
  0x8c, 0x1a, 0x83, 0x31, 0x06, 0x14, 0xd4, 0x28, 
  0x46, 0x41, 0x31, 0x98, 0x00, 0x8c, 0x37, 0x80, 
  0xa9, 0x54, 0x3d, 0x03, 0x33, 0x96, 0xa3, 0x94, 
  0xb3, 0x52, 0x45, 0xd1, 0x21, 0x15, 0x04, 0x55, 
  0x10, 0xef, 0xd1, 0xc2, 0x15, 0x95, 0x3a, 0x03, 
  0x2a, 0xa8, 0x94, 0x71, 0xd4, 0x6f, 0x2b, 0x41, 
  0xb2, 0x2c, 0x9b, 0x02, 0x33, 0x26, 0xd8, 0x06, 
  0x41, 0xf0, 0x8e, 0xaf, 0xae, 0xf6, 0xb8, 0xfe, 
  0xc9, 0x87, 0x18, 0x1b, 0xb0, 0xff, 0xe7, 0x1e, 
  0xdf, 0xfc, 0xb6, 0xcb, 0xe9, 0xc2, 0xa5, 0x02, 
  0xa8, 0x1c, 0xef, 0xf3, 0x71, 0x14, 0xae, 0x12, 
  0x41, 0x55, 0x48, 0xd3, 0x0c, 0xef, 0x7d, 0xa5, 
  0x0a, 0x80, 0x1d, 0x9b, 0xda, 0xe5, 0xe2, 0x23, 
  0x6a, 0xa8, 0x2a, 0xe2, 0x85, 0x6f, 0xa5, 0xcd, 
  0xca, 0xbb, 0x57, 0xb0, 0x8b, 0xcb, 0x64, 0x9d, 
  0x2e, 0x26, 0x30, 0x2c, 0xd6, 0xea, 0xdc, 0xff, 
  0xf8, 0x1a, 0xe9, 0xd3, 0x53, 0xbe, 0xf8, 0xc7, 
  0x15, 0x8b, 0x0f, 0x6f, 0xa0, 0xd7, 0xeb, 0x4d, 
  0xf4, 0x82, 0x9d, 0x0e, 0x31, 0xe0, 0x16, 0x15, 
  0xbe, 0xe7, 0x19, 0xb6, 0xd1, 0x20, 0x3b, 0xee, 
  0x21, 0x89, 0x23, 0x88, 0x2d, 0x18, 0x83, 0x26, 
  0x0e, 0xdf, 0x73, 0x48, 0xea, 0xf8, 0xa9, 0x29, 
  0x7c, 0xd9, 0xf6, 0xf4, 0xd2, 0x14, 0xe7, 0xdc, 
  0xcc, 0x99, 0x5a, 0xc1, 0x88, 0x16, 0xe9, 0x59, 
  0xc4, 0xc9, 0xb8, 0xd8, 0x98, 0xef, 0xb4, 0xf1, 
  0x8b, 0x96, 0x22, 0x26, 0x51, 0x2f, 0x98, 0x9e, 
  0x03, 0x03, 0xea, 0x15, 0xf1, 0x1e, 0x9f, 0x7a, 
  0x7c, 0xea, 0xb8, 0x17, 0x3b, 0x36, 0xbb, 0xb3, 
  0x83, 0x54, 0x30, 0xde, 0xfb, 0x4a, 0x85, 0xd1, 
  0xd8, 0xe8, 0x3f, 0x95, 0xaf, 0xc9, 0xf0, 0x49, 
  0xae, 0xe0, 0x47, 0xbf, 0xfc, 0x5a, 0x4d, 0xf2, 
  0xd7, 0xad, 0xcf, 0xf9, 0xe0, 0xe7, 0x07, 0x00, 
  0xfc, 0xf1, 0xd9, 0x4d, 0x24, 0xcb, 0xa1, 0xca, 
  0xec, 0x9b, 0x9a, 0x24, 0x45, 0xa8, 0x04, 0x39, 
  0x88, 0xe4, 0xbb, 0xf2, 0x03, 0x87, 0x92, 0x17, 
  0x44, 0xf2, 0xb6, 0xf2, 0x6c, 0x71, 0xa9, 0xcb, 
  0x4b, 0x32, 0xbc, 0xe3, 0xec, 0x34, 0xad, 0xea, 
  0x3e, 0xc9, 0x70, 0x49, 0x86, 0x4f, 0x1d, 0x9f, 
  0x76, 0xf6, 0x2e, 0xa6, 0x4c, 0xb9, 0x78, 0x1e, 
  0xd9, 0x2e, 0xcf, 0x14, 0x34, 0x87, 0xd0, 0x61, 
  0x57, 0xf9, 0xd4, 0xe5, 0xbb, 0xf5, 0x32, 0x02, 
  0x93, 0xf5, 0xeb, 0x3d, 0x97, 0x2b, 0x93, 0x79, 
  0xae, 0x15, 0xa7, 0xf2, 0x34, 0x45, 0x86, 0x60, 
  0x2a, 0x10, 0x5f, 0xeb, 0x9f, 0xa4, 0xc5, 0x33, 
  0xcb, 0x32, 0x9e, 0x74, 0x9e, 0xe4, 0x0b, 0x25, 
  0x02, 0xea, 0x08, 0x46, 0x60, 0xdc, 0x00, 0x8c, 
  0xeb, 0x65, 0x88, 0xf3, 0x48, 0x26, 0xfc, 0x1d, 
  0x84, 0x2f, 0x09, 0xe3, 0x04, 0x17, 0x78, 0x44, 
  0x85, 0xfd, 0xbd, 0x83, 0xea, 0x88, 0x1e, 0xb4, 
  0x9d, 0xae, 0xe3, 0xaa, 0x46, 0xd4, 0xd2, 0x61, 
  0x37, 0xa5, 0x27, 0x49, 0xbf, 0xde, 0x4d, 0xc9, 
  0x24, 0x24, 0x15, 0xcb, 0xef, 0x97, 0xaf, 0x4e, 
  0x0c, 0x9a, 0x51, 0x4e, 0x73, 0xe3, 0xc6, 0x0d, 
  0x8d, 0xa2, 0x88, 0x67, 0xed, 0x17, 0xc4, 0xf5, 
  0xc6, 0x54, 0xbf, 0x7e, 0x77, 0x02, 0xb5, 0x40, 
  0xb0, 0x46, 0x08, 0x8d, 0x62, 0x50, 0x0c, 0x20, 
  0x18, 0xbc, 0xe6, 0x25, 0xd3, 0x80, 0xbd, 0x5e, 
  0x97, 0xfb, 0x4b, 0xf3, 0x13, 0xe7, 0xf2, 0xde, 
  0xd3, 0x3e, 0xde, 0x25, 0x8e, 0x63, 0xb6, 0xb7, 
  0xb7, 0xb1, 0xbb, 0xbb, 0xbb, 0x00, 0x5c, 0x8a, 
  0x9b, 0xcc, 0x72, 0xb7, 0x39, 0x4c, 0x84, 0x85, 
  0x5a, 0xd4, 0x87, 0x31, 0xfd, 0x5d, 0x0a, 0x06, 
  0xa7, 0x01, 0x4e, 0x0c, 0x3f, 0x5e, 0x9e, 0x3b, 
  0xbb, 0xf5, 0x51, 0x65, 0x46, 0x64, 0xb3, 0xfd, 
  0x17, 0x67, 0x5f, 0x8e, 0xb3, 0x1f, 0x9a, 0x70, 
  0xeb, 0xe0, 0x88, 0xf7, 0x1b, 0x57, 0x08, 0x51, 
  0x8c, 0xd1, 0x21, 0x98, 0xc4, 0x0b, 0xf7, 0x9a, 
  0x09, 0xc5, 0xe7, 0xf2, 0xe5, 0x60, 0xd0, 0xa9, 
  0x1b, 0x29, 0xcc, 0xd0, 0xba, 0x32, 0x47, 0xe6, 
  0x9e, 0x72, 0xb3, 0x7d, 0xcc, 0xf5, 0xc6, 0x7b, 
  0x18, 0x13, 0xf0, 0x6f, 0x6f, 0x9f, 0x56, 0x33, 
  0x20, 0x9c, 0xaf, 0x13, 0x10, 0xcc, 0x34, 0xd7, 
  0x68, 0x1f, 0x3b, 0xf4, 0x66, 0xc6, 0x2b, 0xa8, 
  0xc1, 0x10, 0xd9, 0x88, 0x87, 0xef, 0x2c, 0xf3, 
  0x90, 0xe2, 0x62, 0xb6, 0x38, 0x47, 0xed, 0xbc, 
  0x55, 0x66, 0xa4, 0xe9, 0xbb, 0xa9, 0xf8, 0x4a, 
  0xbf, 0x4e, 0xd3, 0xb7, 0x11, 0xa6, 0x7c, 0x56, 
  0x30, 0x5d, 0xf7, 0x9c, 0xee, 0x8b, 0xe7, 0xaf, 
  0x15, 0x66, 0xd4, 0x82, 0x37, 0xba, 0x7a, 0x61, 
  0xa6, 0x3c, 0x1f, 0x16, 0x16, 0x16, 0xf2, 0xac, 
  0x7e, 0xc3, 0x45, 0x55, 0xd5, 0xe8, 0x05, 0x03, 
  0x65, 0x6b, 0x6b, 0x8b, 0xed, 0xed, 0x6d, 0x4e, 
  0x4f, 0x4f, 0xcf, 0xed, 0x73, 0x74, 0x74, 0xc4, 
  0x9d, 0x3b, 0x77, 0x2e, 0xac, 0xd0, 0xd4, 0x0b, 
  0xf9, 0xa8, 0x1d, 0x1c, 0x1c, 0xb0, 0xb6, 0xb6, 
  0x56, 0x5d, 0xa2, 0xc7, 0xd9, 0xa3, 0x47, 0x8f, 
  0x2e, 0x0c, 0xf2, 0x52, 0x30, 0x9d, 0x4e, 0x87, 
  0xb5, 0xb5, 0xb5, 0x89, 0x7d, 0xa2, 0x28, 0x9a, 
  0x71, 0xb6, 0x61, 0x9b, 0xc9, 0x4d, 0xaa, 0x4a, 
  0x9a, 0xa6, 0x3c, 0x7e, 0xfc, 0x98, 0xe5, 0xe5, 
  0xe5, 0xb1, 0x5f, 0xf4, 0x51, 0x98, 0xad, 0xad, 
  0x2d, 0x36, 0x36, 0x36, 0x58, 0x5a, 0x5a, 0x22, 
  0x08, 0x66, 0xcb, 0x93, 0x89, 0x30, 0x22, 0x42, 
  0x92, 0x24, 0x24, 0x49, 0xc2, 0xdd, 0xbb, 0x77, 
  0xb9, 0x7d, 0xfb, 0x36, 0x3b, 0x3b, 0x3b, 0x33, 
  0x4d, 0xbc, 0xba, 0xba, 0x0a, 0x40, 0xb3, 0xd9, 
  0xa4, 0x5e, 0xaf, 0x53, 0xaf, 0xd7, 0xb1, 0x76, 
  0xb2, 0x23, 0xa6, 0x2a, 0x53, 0xc2, 0xb4, 0xdb, 
  0x6d, 0x5a, 0xad, 0x16, 0x59, 0x96, 0xe1, 0x9c, 
  0xab, 0xfe, 0x79, 0xca, 0xc3, 0x32, 0x08, 0x02, 
  0x82, 0x20, 0x20, 0x0c, 0x43, 0xac, 0xb5, 0x58, 
  0x6b, 0x89, 0xe3, 0x98, 0xcd, 0xcd, 0x4d, 0xa2, 
  0x28, 0x22, 0x8e, 0xe3, 0x7e, 0x0a, 0xbf, 0x8a, 
  0x9b, 0x4a, 0x57, 0x39, 0xe7, 0x48, 0xd3, 0xb4, 
  0x02, 0x19, 0xfc, 0xe7, 0x36, 0xc6, 0x54, 0x30, 
  0x61, 0x18, 0x52, 0xab, 0xd5, 0xb0, 0xd6, 0x12, 
  0x9e, 0xf7, 0xcb, 0xfc, 0x2a, 0x30, 0xaf, 0xc3, 
  0xfe, 0x07, 0x06, 0x53, 0x33, 0xa4, 0x64, 0x97, 
  0x84, 0x90, 0x00, 0x00, 0x00, 0x25, 0x74, 0x45, 
  0x58, 0x74, 0x64, 0x61, 0x74, 0x65, 0x3a, 0x63, 
  0x72, 0x65, 0x61, 0x74, 0x65, 0x00, 0x32, 0x30, 
  0x31, 0x37, 0x2d, 0x30, 0x38, 0x2d, 0x32, 0x35, 
  0x54, 0x31, 0x36, 0x3a, 0x33, 0x37, 0x3a, 0x31, 
  0x39, 0x2b, 0x30, 0x32, 0x3a, 0x30, 0x30, 0x0d, 
  0x8b, 0xff, 0xce, 0x00, 0x00, 0x00, 0x25, 0x74, 
  0x45, 0x58, 0x74, 0x64, 0x61, 0x74, 0x65, 0x3a, 
  0x6d, 0x6f, 0x64, 0x69, 0x66, 0x79, 0x00, 0x32, 
  0x30, 0x31, 0x37, 0x2d, 0x30, 0x38, 0x2d, 0x32, 
  0x35, 0x54, 0x31, 0x36, 0x3a, 0x33, 0x37, 0x3a, 
  0x31, 0x39, 0x2b, 0x30, 0x32, 0x3a, 0x30, 0x30, 
  0x7c, 0xd6, 0x47, 0x72, 0x00, 0x00, 0x00, 0x1d, 
  0x74, 0x45, 0x58, 0x74, 0x70, 0x73, 0x3a, 0x48, 
  0x69, 0x52, 0x65, 0x73, 0x42, 0x6f, 0x75, 0x6e, 
  0x64, 0x69, 0x6e, 0x67, 0x42, 0x6f, 0x78, 0x00, 
  0x33, 0x35, 0x78, 0x33, 0x33, 0x2b, 0x30, 0x2d, 
  0x31, 0x47, 0x86, 0x87, 0xda, 0x00, 0x00, 0x00, 
  0x1c, 0x74, 0x45, 0x58, 0x74, 0x70, 0x73, 0x3a, 
  0x4c, 0x65, 0x76, 0x65, 0x6c, 0x00, 0x41, 0x64, 
  0x6f, 0x62, 0x65, 0x2d, 0x33, 0x2e, 0x30, 0x20, 
  0x45, 0x50, 0x53, 0x46, 0x2d, 0x33, 0x2e, 0x30, 
  0x0a, 0x9b, 0x70, 0xbb, 0xe3, 0x00, 0x00, 0x00, 
  0x00, 0x49, 0x45, 0x4e, 0x44, 0xae, 0x42, 0x60, 
  0x82, 0x00, 0x00, 0x28, 0x75, 0x75, 0x61, 0x79, 
  0x29
} };

static GStaticResource static_resource = { typebreaker_indicator_resource_data.data, sizeof (typebreaker_indicator_resource_data.data), NULL, NULL, NULL };
extern GResource *typebreaker_indicator_get_resource (void);
GResource *typebreaker_indicator_get_resource (void)
{
  return g_static_resource_get_resource (&static_resource);
}
/*
  If G_HAS_CONSTRUCTORS is true then the compiler support *both* constructors and
  destructors, in a sane way, including e.g. on library unload. If not you're on
  your own.

  Some compilers need #pragma to handle this, which does not work with macros,
  so the way you need to use this is (for constructors):

  #ifdef G_DEFINE_CONSTRUCTOR_NEEDS_PRAGMA
  #pragma G_DEFINE_CONSTRUCTOR_PRAGMA_ARGS(my_constructor)
  #endif
  G_DEFINE_CONSTRUCTOR(my_constructor)
  static void my_constructor(void) {
   ...
  }

*/

#ifndef __GTK_DOC_IGNORE__

#if  __GNUC__ > 2 || (__GNUC__ == 2 && __GNUC_MINOR__ >= 7)

#define G_HAS_CONSTRUCTORS 1

#define G_DEFINE_CONSTRUCTOR(_func) static void __attribute__((constructor)) _func (void);
#define G_DEFINE_DESTRUCTOR(_func) static void __attribute__((destructor)) _func (void);

#elif defined (_MSC_VER) && (_MSC_VER >= 1500)
/* Visual studio 2008 and later has _Pragma */

#define G_HAS_CONSTRUCTORS 1

/* We do some weird things to avoid the constructors being optimized
 * away on VS2015 if WholeProgramOptimization is enabled. First we
 * make a reference to the array from the wrapper to make sure its
 * references. Then we use a pragma to make sure the wrapper function
 * symbol is always included at the link stage. Also, the symbols
 * need to be extern (but not dllexport), even though they are not
 * really used from another object file.
 */

/* We need to account for differences between the mangling of symbols
 * for Win32 (x86) and x64 programs, as symbols on Win32 are prefixed
 * with an underscore but symbols on x64 are not.
 */
#ifdef _WIN64
#define G_MSVC_SYMBOL_PREFIX ""
#else
#define G_MSVC_SYMBOL_PREFIX "_"
#endif

#define G_DEFINE_CONSTRUCTOR(_func) G_MSVC_CTOR (_func, G_MSVC_SYMBOL_PREFIX)
#define G_DEFINE_DESTRUCTOR(_func) G_MSVC_DTOR (_func, G_MSVC_SYMBOL_PREFIX)

#define G_MSVC_CTOR(_func,_sym_prefix) \
  static void _func(void); \
  extern int (* _array ## _func)(void);              \
  int _func ## _wrapper(void) { _func(); g_slist_find (NULL,  _array ## _func); return 0; } \
  __pragma(comment(linker,"/include:" _sym_prefix # _func "_wrapper")) \
  __pragma(section(".CRT$XCU",read)) \
  __declspec(allocate(".CRT$XCU")) int (* _array ## _func)(void) = _func ## _wrapper;

#define G_MSVC_DTOR(_func,_sym_prefix) \
  static void _func(void); \
  extern int (* _array ## _func)(void);              \
  int _func ## _constructor(void) { atexit (_func); g_slist_find (NULL,  _array ## _func); return 0; } \
   __pragma(comment(linker,"/include:" _sym_prefix # _func "_constructor")) \
  __pragma(section(".CRT$XCU",read)) \
  __declspec(allocate(".CRT$XCU")) int (* _array ## _func)(void) = _func ## _constructor;

#elif defined (_MSC_VER)

#define G_HAS_CONSTRUCTORS 1

/* Pre Visual studio 2008 must use #pragma section */
#define G_DEFINE_CONSTRUCTOR_NEEDS_PRAGMA 1
#define G_DEFINE_DESTRUCTOR_NEEDS_PRAGMA 1

#define G_DEFINE_CONSTRUCTOR_PRAGMA_ARGS(_func) \
  section(".CRT$XCU",read)
#define G_DEFINE_CONSTRUCTOR(_func) \
  static void _func(void); \
  static int _func ## _wrapper(void) { _func(); return 0; } \
  __declspec(allocate(".CRT$XCU")) static int (*p)(void) = _func ## _wrapper;

#define G_DEFINE_DESTRUCTOR_PRAGMA_ARGS(_func) \
  section(".CRT$XCU",read)
#define G_DEFINE_DESTRUCTOR(_func) \
  static void _func(void); \
  static int _func ## _constructor(void) { atexit (_func); return 0; } \
  __declspec(allocate(".CRT$XCU")) static int (* _array ## _func)(void) = _func ## _constructor;

#elif defined(__SUNPRO_C)

/* This is not tested, but i believe it should work, based on:
 * http://opensource.apple.com/source/OpenSSL098/OpenSSL098-35/src/fips/fips_premain.c
 */

#define G_HAS_CONSTRUCTORS 1

#define G_DEFINE_CONSTRUCTOR_NEEDS_PRAGMA 1
#define G_DEFINE_DESTRUCTOR_NEEDS_PRAGMA 1

#define G_DEFINE_CONSTRUCTOR_PRAGMA_ARGS(_func) \
  init(_func)
#define G_DEFINE_CONSTRUCTOR(_func) \
  static void _func(void);

#define G_DEFINE_DESTRUCTOR_PRAGMA_ARGS(_func) \
  fini(_func)
#define G_DEFINE_DESTRUCTOR(_func) \
  static void _func(void);

#else

/* constructors not supported for this compiler */

#endif

#endif /* __GTK_DOC_IGNORE__ */

#ifdef G_HAS_CONSTRUCTORS

#ifdef G_DEFINE_CONSTRUCTOR_NEEDS_PRAGMA
#pragma G_DEFINE_CONSTRUCTOR_PRAGMA_ARGS(resource_constructor)
#endif
G_DEFINE_CONSTRUCTOR(resource_constructor)
#ifdef G_DEFINE_DESTRUCTOR_NEEDS_PRAGMA
#pragma G_DEFINE_DESTRUCTOR_PRAGMA_ARGS(resource_destructor)
#endif
G_DEFINE_DESTRUCTOR(resource_destructor)

#else
#warning "Constructor not supported on this compiler, linking in resources will not work"
#endif

static void resource_constructor (void)
{
  g_static_resource_init (&static_resource);
}

static void resource_destructor (void)
{
  g_static_resource_fini (&static_resource);
}
