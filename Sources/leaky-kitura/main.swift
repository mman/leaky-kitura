import Kitura
import Credentials
import CredentialsHTTP
import SwiftyJSON
import Dispatch
import LoggerAPI
import HeliumLogger

Log.logger = HeliumLogger()

let credentials = Credentials()
let users = ["user": "password"]
let basicCredentials = CredentialsHTTPBasic(verifyPassword: { userId, password, callback in
    if let storedPassword = users[userId], storedPassword == password {
        callback(UserProfile(id: userId, displayName: userId, provider: "HTTPBasic"))
    } else {
        callback(nil)
    }
})
credentials.register(plugin: basicCredentials)

let router = Router()
let status = JSON(["status": "OK"]).rawString(options: [])!

#if os(Linux)
let pemKeyFile = "key.pem"
let pemCertificateFile = "cert.pem"
let sslConfig = SSLConfig(withCACertificateFilePath: pemCertificateFile, usingCertificateFile: pemCertificateFile, withKeyFile: pemKeyFile, usingSelfSignedCerts: false)
#else
let pfxCertificateAndKeyFile = "cert.pfx"
let pfxCertificateAndKeyFilePassword = "password"
let sslConfig = SSLConfig(withChainFilePath: pfxCertificateAndKeyFile, withPassword: pfxCertificateAndKeyFilePassword, usingSelfSignedCerts: true)
#endif

router.all("/", middleware: credentials)
router.get("/") {
    request, response, next in
    response.send(status)
    next()
}

Kitura.addHTTPServer(onPort: 8080, with: router, withSSL: sslConfig)
Kitura.start()

dispatchMain()
