struct ComicFormatter {
    var comic: Comic

    func posterThumbnailImage() -> String {
        if let path = comic.thumbnail?.path, !path.isEmpty, let imgExtension = comic.thumbnail?.imgExtension, !imgExtension.isEmpty {
            return "\(path).\(imgExtension)"
        }
        return ""
    }

    func posterImage() -> String {
        let retUrl = posterThumbnailImage()
        guard let images = comic.images else {
            return retUrl
        }

        for currImage in images {
            if let path = currImage.path, !path.isEmpty, let imgExtension = currImage.imgExtension, !imgExtension.isEmpty {
                return "\(path).\(imgExtension)"
            }
        }
        return retUrl
    }

    func title() -> String {
        return comic.title ?? "MARVEL"
    }

    // Decide to add fallback logic here and use textObjects if description is null
    // This is for the Demo as in an actual production app, these type of rules are dictated by Product Team
    // My decision was based on the comment from the API Documentation:
    // textObjects (Array[TextObject], optional): A set of descriptive text blurbs for the comic.
    func description() -> String {
        var retDescription: String = ""
        retDescription = comic.description ?? ""

        if retDescription.isEmpty, let textObjects = comic.textObjects {
            for currTextObject in textObjects {
                if let text = currTextObject.text, !text.isEmpty {
                    retDescription = text
                    break
                }
            }
        }

        return retDescription
    }
}
