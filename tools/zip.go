package main

import (
    "fmt"
    "io"
    "os"
    "log"
    "strings"
    "image"
    "image/jpeg"
    "image/png"
    "path/filepath"
    "io/ioutil"
    "archive/zip"
)

func convert(filename string) (string, error) {

    var filebase string
    var imgSrc image.Image
    var oldSize int64
    var newSize int64
    fi, _ := os.Stat(filename)
    oldSize = fi.Size()
    if strings.HasSuffix(filename, ".png") {
        pngImgFile, err := os.Open(filename)

        if err != nil {
            fmt.Println("file not found!")
            os.Exit(1)
        }

        defer pngImgFile.Close()

        imgSrc, err = png.Decode(pngImgFile)

        if err!=nil {
            log.Fatal(err)
        }
        filebase = strings.TrimSuffix(filename, ".png")
    } else if strings.HasSuffix(filename, ".jpg") || strings.HasSuffix(filename, ".jpeg") {

        jpgImgSrc, err := os.Open(filename)
        if err != nil {
            fmt.Println("file not found!")
            os.Exit(1)
        }

        defer jpgImgSrc.Close()

        imgSrc, err = jpeg.Decode(jpgImgSrc)
        if err!=nil {
            log.Fatal(err)
        }
        if strings.HasSuffix(filename, ".jpg") {
            filebase = strings.TrimSuffix(filename, ".jpg")
        } else {
            filebase = strings.TrimSuffix(filename, ".jpeg")
        }
    } else {
        return "", fmt.Errorf("err")
    }


    jpgImgFile, err := os.Create(filebase + ".jpg")

    if err != nil {
        fmt.Println("Cannot create jpg!")
        fmt.Println("err")
        os.Exit(1)
    }

    defer jpgImgFile.Close()

    var opt jpeg.Options
    opt.Quality = 50

    err = jpeg.Encode(jpgImgFile, imgSrc, &opt)

    if err != nil {
        log.Fatal(err)
    }
    fi, _ = jpgImgFile.Stat()
    newSize = fi.Size()

    fmt.Println(filename, oldSize/1000, "KB ->", newSize/1000, "KB")

    return filebase + ".jpg", nil
}

func main() {

    files, err := ioutil.ReadDir("./")
    if err != nil {
        log.Fatal(err)
    }

    for _, f := range files {
        if f.IsDir() {
            var outfiles []string
            fmt.Println(f.Name())
            err := filepath.Walk(f.Name(), func(path string, info os.FileInfo, err error) error {
                outname, err := convert(path)
                if err != nil {
                    return nil
                } else {
                    outfiles = append(outfiles, outname)
                }
                return nil
            })
            if err != nil {
                log.Fatal(err)
            }
            err = ZipFiles(filepath.Join(f.Name() + ".zip"), outfiles)
            if err != nil {
                log.Fatal(err)
            }
        }
    }

}

func ZipFiles(filename string, files []string) error {

    newZipFile, err := os.Create(filename)
    if err != nil {
        return err
    }
    defer newZipFile.Close()

    zipWriter := zip.NewWriter(newZipFile)
    defer zipWriter.Close()

    // Add files to zip
    for _, file := range files {

        zipfile, err := os.Open(file)
        if err != nil {
            return err
        }
        defer zipfile.Close()

        // Get the file information
        info, err := zipfile.Stat()
        if err != nil {
            return err
        }

        header, err := zip.FileInfoHeader(info)
        if err != nil {
            return err
        }

        // Using FileInfoHeader() above only uses the basename of the file. If we want
        // to preserve the folder structure we can overwrite this with the full path.
        header.Name = file

        // Change to deflate to gain better compression
        // see http://golang.org/pkg/archive/zip/#pkg-constants
        header.Method = zip.Deflate

        writer, err := zipWriter.CreateHeader(header)
        if err != nil {
            return err
        }
        if _, err = io.Copy(writer, zipfile); err != nil {
            return err
        }
    }
    return nil
}