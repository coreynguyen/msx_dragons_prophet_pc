#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <cstdint>
#include <string>
#include <vector>
#include <iostream>
#include <fstream>

// Constants for the sliding window and maximum match length
const size_t WINDOW_SIZE = 4096;     // Size of the sliding window
const size_t MAX_MATCH_LENGTH = 18;  // Maximum length of a match


// I can't seem to get IDXUnpacker to work, its missing DPlib.dll
// So, pulled the Function From HexRays

// positive sp value has been detected, the output may be wrong!
// a1 = probably input   
void __usercall start(int a1@<eax>, int a2@<edx>, int a3@<ecx>, double a4@<st0>)
{
  int v4; // eax
  bool v5; // cf
  int v6; // ecx
  int v7; // ebp
  _BYTE *v8; // ecx
  char v10; // bl
  char v11; // tt
  int v12; // esi
  _BYTE *v13; // ecx
  int *v14; // esi
  int *v15; // edi
  unsigned int v16; // ebp
  char v17; // al
  bool v18; // cf
  int v19; // ebx
  int v20; // ebx
  int v21; // ett
  int i; // eax
  bool v23; // cf
  int v24; // ebx
  int v25; // ebx
  int v26; // ett
  unsigned int v27; // eax
  bool v28; // zf
  int v29; // ebx
  int v30; // ett
  unsigned int v31; // eax
  bool v32; // cf
  int v33; // ebx
  int v34; // ett
  bool v35; // cf
  int v36; // ebx
  int v37; // ett
  int v38; // ecx
  int v39; // ecx
  unsigned int v40; // eax
  unsigned int v41; // eax
  int v42; // eax
  bool v43; // cf
  int v44; // ebx
  int v45; // ett
  bool v46; // cf
  int v47; // ebx
  int v48; // ett
  bool v49; // cf
  int v50; // ebx
  int v51; // ebx
  int v52; // ett
  bool v53; // zf
  int v54; // ebx
  int v55; // ett
  unsigned int v56; // ecx
  char *v57; // edx
  char v58; // al
  int v59; // eax
  bool v60; // cc
  int *v61; // esi
  int *v62; // edi
  int v63; // ecx
  char v64; // al
  unsigned __int8 v65; // al
  int v66; // eax
  int v67; // eax
  char v68; // t0
  unsigned __int8 v69; // bl
  char *v70; // edi
  int v71; // eax
  int *v72; // ebx
  int v73; // ebp
  char v74; // al
  char *v75; // ecx
  unsigned __int8 v76; // al
  int v77; // eax
  void (__cdecl *v78)(int *, int, int, int *); // ebp
  int *v79; // edi
  int v80; // edx
  int v81; // ecx
  int v82; // ebx
  int v83; // ebp
  int v84; // edi
  int v85; // esi
  int v87; // [esp+14h] [ebp-98h]
  int v88; // [esp+18h] [ebp-94h]
  _DWORD v89[4]; // [esp+1Ch] [ebp-90h] BYREF
  int v90; // [esp+2Ch] [ebp-80h] BYREF
  int v91; // [esp+30h] [ebp-7Ch] BYREF
  char *v92; // [esp+34h] [ebp-78h]
  int *v93; // [esp+38h] [ebp-74h]
  int v94; // [esp+3Ch] [ebp-70h]
  int v95; // [esp+40h] [ebp-6Ch]
  int v96; // [esp+44h] [ebp-68h]
  int v97; // [esp+48h] [ebp-64h]
  int *v98; // [esp+4Ch] [ebp-60h]
  int v99; // [esp+50h] [ebp-5Ch]
  int v100; // [esp+54h] [ebp-58h]
  int v101; // [esp+58h] [ebp-54h]
  int v102; // [esp+5Ch] [ebp-50h] BYREF
  _BYTE *v103; // [esp+9Ch] [ebp-10h]
  int v104; // [esp+A0h] [ebp-Ch]
  int v105; // [esp+A4h] [ebp-8h]
  void **v106; // [esp+A8h] [ebp-4h]
  void *retaddr; // [esp+ACh] [ebp+0h] BYREF

  v98 = &v102;
  v96 = a3;
  v95 = a2;
  v94 = a1;
  v14 = dword_45A000;
  v15 = &dword_45A000[-91136];
  dword_45A000[22567] = -1340021855;
  v93 = &dword_45A000[-91136];
  v16 = -1;
  while ( 1 )
  {
    v20 = *v14;
    v18 = (unsigned int)v14++ < 0xFFFFFFFC;
    v21 = v18 + v20;
    v18 = __CFADD__(v18, v20) | __CFADD__(v20, v21);
    v19 = v20 + v21;
    do
    {
      if ( v18 )
      {
        v17 = *(_BYTE *)v14;
        v14 = (int *)((char *)v14 + 1);
        *(_BYTE *)v15 = v17;
        v15 = (int *)((char *)v15 + 1);
      }
      else
      {
        for ( i = 1; ; i = v31 + v32 + v31 )
        {
          v23 = __CFADD__(v19, v19);
          v24 = 2 * v19;
          if ( !v24 )
          {
            v25 = *v14;
            v18 = (unsigned int)v14++ < 0xFFFFFFFC;
            v26 = v18 + v25;
            v23 = __CFADD__(v18, v25) | __CFADD__(v25, v26);
            v24 = v25 + v26;
          }
          v27 = i + v23 + i;
          v18 = __CFADD__(v24, v24);
          v28 = 2 * v24 == 0;
          v19 = 2 * v24;
          if ( v18 )
          {
            if ( !v28 )
              break;
            v29 = *v14;
            v18 = (unsigned int)v14++ < 0xFFFFFFFC;
            v30 = v18 + v29;
            v18 = __CFADD__(v18, v29) | __CFADD__(v29, v30);
            v19 = v29 + v30;
            if ( v18 )
              break;
          }
          v31 = v27 - 1;
          v32 = __CFADD__(v19, v19);
          v19 *= 2;
          if ( !v19 )
          {
            v33 = *v14;
            v18 = (unsigned int)v14++ < 0xFFFFFFFC;
            v34 = v18 + v33;
            v32 = __CFADD__(v18, v33) | __CFADD__(v33, v34);
            v19 = v33 + v34;
          }
        }
        v39 = 0;
        v18 = v27 < 3;
        v40 = v27 - 3;
        if ( v18 )
        {
          v43 = __CFADD__(v19, v19);
          v19 *= 2;
          if ( !v19 )
          {
            v44 = *v14;
            v18 = (unsigned int)v14++ < 0xFFFFFFFC;
            v45 = v18 + v44;
            v43 = __CFADD__(v18, v44) | __CFADD__(v44, v45);
            v19 = v44 + v45;
          }
        }
        else
        {
          v41 = v40 << 8;
          LOBYTE(v41) = *(_BYTE *)v14;
          v14 = (int *)((char *)v14 + 1);
          v42 = ~v41;
          if ( !v42 )
          {
            v61 = v93;
            v62 = v93;
            v63 = 14203;
            while ( 1 )
            {
              v64 = *(_BYTE *)v62;
              v62 = (int *)((char *)v62 + 1);
              v65 = v64 + 24;
              while ( v65 <= 1u && *(_BYTE *)v62 == 22 )
              {
                v66 = *v62;
                LOWORD(v66) = BYTE1(*v62);
                v67 = __ROL4__(v66, 16);
                v68 = v67;
                LOBYTE(v67) = BYTE1(v67);
                BYTE1(v67) = v68;
                v69 = *((_BYTE *)v62 + 4) + 24;
                *v62 = (int)v61 + v67 - (_DWORD)v62;
                v62 = (int *)((char *)v62 + 5);
                v65 = v69;
                if ( !--v63 )
                {
                  v70 = (char *)(v61 + 138240);
LABEL_44:
                  v71 = *(_DWORD *)v70;
                  if ( *(_DWORD *)v70 )
                  {
                    v72 = (int *)((char *)v61 + *((_DWORD *)v70 + 1));
                    v70 += 8;
                    v73 = ((int (__cdecl *)(int, int, int, int, int, int *, int, int, int))v61[143511])(
                            (int)v61 + v71 + 573804,
                            v94,
                            v95,
                            v96,
                            v97,
                            v98,
                            v99,
                            v100,
                            v101);
                    while ( 1 )
                    {
                      v74 = *v70++;
                      if ( !v74 )
                        goto LABEL_44;
                      v75 = v70;
                      v92 = v70;
                      v76 = v74 - 1;
                      do
                      {
                        if ( !v75 )
                          break;
                        v28 = *v70++ == (char)v76;
                        --v75;
                      }
                      while ( !v28 );
                      v77 = ((int (__cdecl *)(int, char *))v61[143512])(v73, v92);
                      if ( !v77 )
                        break;
                      *v72++ = v77;
                    }
                    v71 = ((int (*)(void))v61[143516])();
                  }
                  v78 = (void (__cdecl *)(int *, int, int, int *))v61[143513];
                  v79 = v61 - 1024;
                  v90 = v71;
                  v78(v61 - 1024, 4096, 4, &v90);
                  *((_BYTE *)v79 + 543) &= 0x7Fu;
                  *((_BYTE *)v79 + 583) &= 0x7Fu;
                  v78(v61 - 1024, 4096, v89[0], v89);
                  v80 = v87;
                  v81 = v88;
                  v82 = v89[0];
                  v83 = v89[2];
                  v84 = v89[3];
                  v85 = v90;
                  _EAX = &v91 - 32;
                  do
                    v90 = 0;
                  while ( &v90 != _EAX );
                  while ( 1 )
                  {
                    *(_DWORD *)(v83 + 1197119465) &= v81;
                    __asm { icebp }
                    v5 = __CFSHL__(MEMORY[0x8DCF9467], 20);
                    MEMORY[0x8DCF9467] = __ROL1__(MEMORY[0x8DCF9467], 20);
                    ++v83;
                    *(_BYTE *)(v80 + 1234335764) = ~*(_BYTE *)(v80 + 1234335764);
                    v106 = &retaddr;
                    __outbyte(v80, (unsigned __int8)_EAX);
                    v6 = v81 - 1;
                    if ( v6 )
                    {
                      v4 = v6;
                    }
                    else
                    {
                      LOBYTE(_EAX) = 61;
                      *(_BYTE *)(v80 + 422582036) += v80;
                      v105 = ++v80;
                      v60 = *(_BYTE *)_EAX < BYTE1(v82) || v83 == -1;
                      v7 = v83 + 1;
                      v8 = *(_BYTE **)((unsigned __int8)-(char)(v5 + BYTE1(_EAX)) + 0x62941B84);
                      __DS__ = *(_WORD *)((unsigned __int8)-(char)(v5 + BYTE1(_EAX)) + 0x62941B88);
                      __asm { aam     23h ; '#' }
                      v104 = (unsigned __int16)__CS__;
                      if ( v60 )
                        JUMPOUT(0x46F7F3);
                      v4 = *(_DWORD *)(v85 + 35);
                      LOBYTE(v4) = v4 ^ 0x17;
                      v18 = (unsigned __int8)v82 < BYTE1(v8);
                      v103 = v8;
                      v11 = v82;
                      v10 = *(_BYTE *)(v84 - 96);
                      *(_BYTE *)(v84 - 96) = v11;
                      BYTE1(v80) = 84;
                      LOBYTE(v82) = *v8 + v18 + v10;
                      v83 = v7 - 1;
                      v12 = v85 + 1;
                      a4 = a4 * *(float *)(v12 - 63);
                      LOBYTE(v8) = -113;
                      v85 = v12 + 1;
                      v13 = v8 - 1;
                      if ( v85 || !v13 )
                      {
                        v103 = (_BYTE *)(v82 - 1);
                        JUMPOUT(0x46F812);
                      }
                    }
                    a4 = a4 - a4;
                    v81 = 89593898 * *(_DWORD *)(v4 - 21);
                    LOBYTE(_EAX) = 125;
                    _EAX = (int *)(__int16)_EAX;
                    BYTE1(_EAX) = -31;
                  }
                }
              }
            }
          }
          v43 = v42 & 1;
          v16 = v42 >> 1;
        }
        if ( v43 )
          goto LABEL_15;
        v39 = 1;
        v46 = __CFADD__(v19, v19);
        v19 *= 2;
        if ( !v19 )
        {
          v47 = *v14;
          v18 = (unsigned int)v14++ < 0xFFFFFFFC;
          v48 = v18 + v47;
          v46 = __CFADD__(v18, v47) | __CFADD__(v47, v48);
          v19 = v47 + v48;
        }
        if ( v46 )
        {
LABEL_15:
          v35 = __CFADD__(v19, v19);
          v19 *= 2;
          if ( !v19 )
          {
            v36 = *v14;
            v18 = (unsigned int)v14++ < 0xFFFFFFFC;
            v37 = v18 + v36;
            v35 = __CFADD__(v18, v36) | __CFADD__(v36, v37);
            v19 = v36 + v37;
          }
          v38 = v39 + v35 + v39;
        }
        else
        {
          while ( 1 )
          {
            v49 = __CFADD__(v19, v19);
            v50 = 2 * v19;
            if ( !v50 )
            {
              v51 = *v14;
              v18 = (unsigned int)v14++ < 0xFFFFFFFC;
              v52 = v18 + v51;
              v49 = __CFADD__(v18, v51) | __CFADD__(v51, v52);
              v50 = v51 + v52;
            }
            v39 += v49 + v39;
            v18 = __CFADD__(v50, v50);
            v53 = 2 * v50 == 0;
            v19 = 2 * v50;
            if ( v18 )
            {
              if ( !v53 )
                break;
              v54 = *v14;
              v18 = (unsigned int)v14++ < 0xFFFFFFFC;
              v55 = v18 + v54;
              v18 = __CFADD__(v18, v54) | __CFADD__(v54, v55);
              v19 = v54 + v55;
              if ( v18 )
                break;
            }
          }
          v38 = v39 + 2;
        }
        v56 = (v16 < 0xFFFFFB00) + v38 + 2;
        v57 = (char *)v15 + v16;
        if ( v16 <= 0xFFFFFFFC )
        {
          do
          {
            v59 = *(_DWORD *)v57;
            v57 += 4;
            *v15++ = v59;
            v60 = v56 <= 4;
            v56 -= 4;
          }
          while ( !v60 );
          v15 = (int *)((char *)v15 + v56);
        }
        else
        {
          do
          {
            v58 = *v57++;
            *(_BYTE *)v15 = v58;
            v15 = (int *)((char *)v15 + 1);
            --v56;
          }
          while ( v56 );
        }
      }
      v18 = __CFADD__(v19, v19);
      v19 *= 2;
    }
    while ( v19 );
  }
}

// without a sample of the idx archive, its impossible to test. 
// on another post Ekey noted that the archive was a custom compression of LMZA
/**
 * Decompresses data using a modified LZSS-like algorithm.
 *
 * @param inputData Pointer to the compressed input data.
 * @param inputSize Size of the compressed input data.
 * @param outputData Pointer to the buffer where decompressed data will be stored.
 * @param outputSize Reference to a variable where the size of the decompressed data will be stored.
 * @return True if decompression is successful, false otherwise.
 */
bool DecompressData(const unsigned char* inputData, size_t inputSize, unsigned char* outputData, size_t& outputSize) {
    size_t inputPos = 0;    // Current position in the input buffer
    size_t outputPos = 0;   // Current position in the output buffer
    unsigned char flagByte = 0; // Current flag byte
    int flagBit = 0;        // Current bit in the flag byte

    // Initialize the sliding window with zeros
    std::vector<unsigned char> slidingWindow(WINDOW_SIZE, 0);
    size_t windowPos = 0;   // Current position in the sliding window

    while (inputPos < inputSize) {
        // If all bits in the flag byte have been processed, read the next flag byte
        if (flagBit == 0) {
            flagByte = inputData[inputPos++];
            flagBit = 8;
        }

        // Process the next bit in the flag byte
        flagBit--;

        if (flagByte & (1 << flagBit)) {
            // Literal byte
            if (inputPos >= inputSize) {
                std::cerr << "Unexpected end of input data while reading a literal byte." << std::endl;
                return false;
            }

            unsigned char literal = inputData[inputPos++];
            outputData[outputPos++] = literal;

            // Update the sliding window
            slidingWindow[windowPos] = literal;
            windowPos = (windowPos + 1) % WINDOW_SIZE;
        } else {
            // Back-reference
            if (inputPos + 1 >= inputSize) {
                std::cerr << "Unexpected end of input data while reading a back-reference." << std::endl;
                return false;
            }

            // Read two bytes for the back-reference
            unsigned char byte1 = inputData[inputPos++];
            unsigned char byte2 = inputData[inputPos++];

            // Calculate the offset and length
            size_t offset = ((byte1 & 0xF0) << 4) | byte2;
            size_t length = (byte1 & 0x0F) + 3;

            if (offset == 0) {
                std::cerr << "Invalid back-reference with offset 0." << std::endl;
                return false;
            }

            // Ensure the offset does not exceed the sliding window
            if (offset > WINDOW_SIZE) {
                std::cerr << "Back-reference offset exceeds sliding window size." << std::endl;
                return false;
            }

            // Copy the data from the sliding window to the output buffer
            for (size_t i = 0; i < length; ++i) {
                size_t copyPos = (windowPos + WINDOW_SIZE - offset) % WINDOW_SIZE;
                unsigned char byteToCopy = slidingWindow[copyPos];
                outputData[outputPos++] = byteToCopy;

                // Update the sliding window
                slidingWindow[windowPos] = byteToCopy;
                windowPos = (windowPos + 1) % WINDOW_SIZE;

                // Prevent buffer overflow
                if (outputPos >= MAX_MATCH_LENGTH * 2 * WINDOW_SIZE) {
                    std::cerr << "Output buffer overflow detected." << std::endl;
                    return false;
                }
            }
        }
    }

    outputSize = outputPos;
    return true;
}

/**
 * Reads a file into a buffer.
 *
 * @param filePath Path to the file to be read.
 * @param buffer Reference to a pointer that will hold the allocated buffer.
 * @param size Reference to a variable that will hold the size of the buffer.
 * @return True if the file is read successfully, false otherwise.
 */
bool ReadFileToBuffer(const std::string& filePath, unsigned char*& buffer, size_t& size) {
    std::ifstream file(filePath.c_str(), std::ios::binary | std::ios::ate);
    if (!file.is_open()) {
        std::cerr << "Failed to open file: " << filePath << std::endl;
        return false;
    }

    size = file.tellg();
    file.seekg(0, std::ios::beg);

    buffer = new unsigned char[size];
    if (!buffer) {
        std::cerr << "Memory allocation failed for file buffer." << std::endl;
        file.close();
        return false;
    }

    file.read(reinterpret_cast<char*>(buffer), size);
    file.close();

    return true;
}

/**
 * Writes a buffer to a file.
 *
 * @param filePath Path to the output file.
 * @param buffer Pointer to the buffer containing data to write.
 * @param size Size of the buffer.
 * @return True if the file is written successfully, false otherwise.
 */
bool WriteBufferToFile(const std::string& filePath, const unsigned char* buffer, size_t size) {
    std::ofstream file(filePath.c_str(), std::ios::binary);
    if (!file.is_open()) {
        std::cerr << "Failed to create output file: " << filePath << std::endl;
        return false;
    }

    file.write(reinterpret_cast<const char*>(buffer), size);
    file.close();

    return true;
}

/**
 * Decompresses a file using the DecompressData function.
 *
 * @param inputFilePath Path to the compressed input file.
 * @param outputFilePath Path to the decompressed output file.
 * @return True if decompression is successful, false otherwise.
 */
bool DecompressFile(const std::string& inputFilePath, const std::string& outputFilePath) {
    unsigned char* compressedData = nullptr;
    size_t compressedSize = 0;

    // Read the compressed input file into a buffer
    if (!ReadFileToBuffer(inputFilePath, compressedData, compressedSize)) {
        return false;
    }

    // Allocate a buffer for the decompressed data
    // Assuming the decompressed size is not more than 10 times the compressed size
    size_t decompressedBufferSize = compressedSize * 10;
    unsigned char* decompressedData = new unsigned char[decompressedBufferSize];
    if (!decompressedData) {
        std::cerr << "Memory allocation failed for decompressed data buffer." << std::endl;
        delete[] compressedData;
        return false;
    }

    size_t decompressedSize = 0;

    // Perform decompression
    if (!DecompressData(compressedData, compressedSize, decompressedData, decompressedSize)) {
        std::cerr << "Decompression failed for file: " << inputFilePath << std::endl;
        delete[] compressedData;
        delete[] decompressedData;
        return false;
    }

    // Write the decompressed data to the output file
    if (!WriteBufferToFile(outputFilePath, decompressedData, decompressedSize)) {
        delete[] compressedData;
        delete[] decompressedData;
        return false;
    }

    // Clean up
    delete[] compressedData;
    delete[] decompressedData;

    std::cout << "Decompression successful: " << outputFilePath << std::endl;
    return true;
}

/**
 * Entry point of the program.
 *
 * Usage: decompressor <compressed_input_file> <decompressed_output_file>
 *
 * @param argc Argument count.
 * @param argv Argument vector.
 * @return Exit status.
 */
int main(int argc, char* argv[]) {
    if (argc != 3) {
        std::cerr << "Usage: decompressor <compressed_input_file> <decompressed_output_file>" << std::endl;
        return 1;
    }

    std::string compressedInputFile = argv[1];
    std::string decompressedOutputFile = argv[2];

    if (!DecompressFile(compressedInputFile, decompressedOutputFile)) {
        std::cerr << "An error occurred during decompression." << std::endl;
        return 1;
    }

    return 0;
}
