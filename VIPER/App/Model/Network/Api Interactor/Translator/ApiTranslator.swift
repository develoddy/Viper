import UIKit

class ApiTranslator: NSObject {
    /* TODO: TRADUCTOR DE DATA A JSON
     * ESTE METODO SE ENCARGA DE TRADUCIR LOS DATOS A UN FORMATO JSON. */
    class func translate<T : Decodable>(data: Data, modelToDecode: T.Type, completion: @escaping ((Result<T, Error>)) -> Void ) {
        do {
            let task = try JSONDecoder().decode(T.self, from: data)
            completion(.success(task))
        } catch {
            completion(.failure(Error.self as! Error) )
        }
    }
}
