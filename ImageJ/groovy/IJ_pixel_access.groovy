/**
 * Testing different methods of accessing pixel values from
 * an ImageProcessor within ImageJ1.
 *
 * (Personally, I prefer getf(x, y)....)
 *
 * Created by Pete on 23/11/2016.
 */

import ij.process.*

// Create 2x2 images for different kinds of ImageProcessor,
// with pixel values [1, 2; 128, 129]
def imageProcessors = [
        new ByteProcessor(2, 2, [1f, 2f, 128f, 129f] as byte[]),
        new ShortProcessor(2, 2, [1f, 2f, 128f, 129f] as short[], null),
        new FloatProcessor(2, 2, [1f, 2f, 128f, 129f] as float[])
]

// Methods for accessing pixels
def methodMap = [
        'get' : {ImageProcessor ip, int x, int y -> ip.get(x, y)},
        'getPixel' : {ImageProcessor ip, int x, int y -> ip.getPixel(x, y)},
        'getf' : {ImageProcessor ip, int x, int y -> ip.getf(x, y)},
        'getPixelValue' : {ImageProcessor ip, int x, int y -> ip.getPixelValue(x, y)},
        'getPixels()[]' : {ImageProcessor ip, int x, int y -> ip.getPixels()[y*ip.getWidth()+x]}
]

// Loop through the ImageProcessors
for (def ip in imageProcessors) {
    println("-----------------------------")
    println(ip.getClass().getSimpleName().toUpperCase())

    // Loop through the pixel access methods & print the results
    methodMap.each { entry ->
        println()
        println("Accessing pixels with " + entry.getKey() + ":")
        println()
        def method = entry.getValue()
        for (int y = 0; y < ip.getHeight(); y++) {
            for (int x = 0; x < ip.getWidth(); x++) {
                print("\t" + method(ip, x, y))
            }
        }
        println()
    }
}
println("-----------------------------")