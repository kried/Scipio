import Foundation
import TSCBasic

struct InfoPlistGenerator {
    private let fileSystem: any FileSystem
    private let buildOptions: BuildOptions

    init(
        fileSystem: any FileSystem,
        buildOptions: BuildOptions
    ) {
        self.fileSystem = fileSystem
        self.buildOptions = buildOptions
    }

    func generateForResourceBundle(at path: AbsolutePath) throws {
        let body = resourceBundleBody
        #if swift(>=5.10)
        try fileSystem.writeFileContents(path.spmAbsolutePath, string: body)
        #else
        try fileSystem.writeFileContents(path, string: body)
        #endif
    }

    private var resourceBundleBody: String {
        """
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
        <plist version="1.0">
        <dict>
            <key>CFBundleDevelopmentRegion</key>
            <string>$(DEVELOPMENT_LANGUAGE)</string>
            <key>CFBundleIdentifier</key>
            <string>$(PRODUCT_BUNDLE_IDENTIFIER)</string>
            <key>CFBundleInfoDictionaryVersion</key>
            <string>6.0</string>
            <key>CFBundleName</key>
            <string>$(PRODUCT_NAME)</string>
            <key>CFBundlePackageType</key>
            <string>BNDL</string>
            <key>CFBundleShortVersionString</key>
            <string>\(buildOptions.libraryVersion)</string>
            <key>CFBundleVersion</key>
            <string>1</string>
        </dict>
        </plist>
        """
    }
}
