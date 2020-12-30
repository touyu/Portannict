import Foundation
import ApolloCodegenLib

// Grab the parent folder of this file on the filesystem
let parentFolderOfScriptFile = FileFinder.findParentFolder()

// Use that to calculate the source root of both the
let sourceRootURL = parentFolderOfScriptFile
    .apollo.parentFolderURL() // Sources
    .apollo.parentFolderURL() // Codegen
    .apollo.parentFolderURL() // MyProject

// From the source root, figure out where your target
// root is within your main project
let targetRootURL = sourceRootURL
    .apollo.childFolderURL(folderName: "Sources")

// Set up the URL you want to use to download the project
let endpoint = URL(string: "https://api.annict.com/graphql")!

// Create an options object for downloading the schema
let schemaDownloadOptions = ApolloSchemaOptions(endpointURL: endpoint,
                                                headers: ["Authorization: Bearer 1Nr6dv0PB1DRdugaL8GAHtPtirQXCdq7embWuBKXg1k"],
                                                outputFolderURL: targetRootURL)
//
// Calculate where you want to create the folder where the CLI will
// be downloaded by the ApolloCodegenLib framework.
let cliFolderURL = sourceRootURL
    .apollo.childFolderURL(folderName: "Codegen")
    .apollo.childFolderURL(folderName: "ApolloCLI")

do {
  // Actually attempt to download the schema.
  try ApolloSchemaDownloader.run(with: cliFolderURL,
                                 options: schemaDownloadOptions)
} catch {
  // This makes the error message in Xcode a lot more legible,
  // and prevents the script from continuing to try to generate
  // code if the schema download failed.
  exit(1)
}

// Create the default Codegen options object (assumes schema.json
// is in the target root folder, all queries are in some kind
// of subfolder of the target folder and will output as a
// single file to API.swift in the target folder)
let codegenOptions = ApolloCodegenOptions(targetRootURL: targetRootURL)

do {
    // Actually attempt to generate code.
    try ApolloCodegen.run(from: targetRootURL,
                          with: cliFolderURL,
                          options: codegenOptions)
} catch {
    // This makes the error message in Xcode a lot more legible.
    exit(1)
}
