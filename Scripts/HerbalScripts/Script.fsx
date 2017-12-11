open System
open System.IO
open System.Drawing
open System.Text.RegularExpressions

#I "/Users/oliversamson/Documents/TheHerbalEscape/Scripts/packages/FSharp.Data.2.4.3/lib/net45"
#r "FSharp.Data"

open FSharp.Data

/// Some properly hacky stuff to scrape some Plant conteReadnt.



let nameRegex = Regex(">([^<]+)<")
let imageRegex = Regex("^<a href=\"([^\"]+)\"")

let findName (line:string) =
    let m = nameRegex.Match(line)
    if m.Success then
        m.Groups.[1].Value
    else
        line

let findImage (line:string) =
    let m = imageRegex.Match(line)
    if m.Success then
        let f = m.Groups.[1].Value.Replace("/wiki/", "")
        let fwiki = "https://en.wikipedia.org/wiki/List_of_plants_used_in_herbalism#/media/" + f
        let fdownloads = "/Users/oliversamson/Downloads/" + (f.Replace("File:", ""))
        Some(fwiki, fdownloads)
    else
        None

let lines =
    @"Users/oliversamson/Documents/TheHerbalEscape/Scripts/Scripts/PlantsWikipedia.txt"
    |> File.ReadAllText
    |> fun t -> t.Split([|"</tr>\n<tr>"|], StringSplitOptions.RemoveEmptyEntries)
    |> Seq.map (fun flower -> flower.Split([|"</td>\n<td>"|], StringSplitOptions.RemoveEmptyEntries))
    |> Seq.map
        (fun a ->
            let latinName = if a.Length >= 1 then a.[0] |> findName else ""
            let commonName = if a.Length >= 2 then a.[1] |> findName else ""
            let imageUrl = if a.Length >= 4 then a.[3] |> findImage else None
            (commonName, latinName, imageUrl))
let text =
    lines
    |> Seq.choose
        (fun (a,b,c) -> c |> Option.bind (fun (_,d) -> if d |> File.Exists then Some (a,b,d) else None))
    |> Seq.map
        (fun (commonName,latinName,fullImageDownloadFile) ->
            let imageName = commonName.ToLower().Replace(" ", "").Replace(".jpg", "")
            let jsonText = sprintf "{\n\"CommonName\": \"%s\",\n\"LatinName\": \"%s\",\n\"ImageName\": \"%s\",\n\"Level\": 1,\n\"HerbalFamily\": \"TODO\",\n\"PartsUsed\": [],\n\"Regions\": [],\n\"Actions\": [],\n\"Constituents\": [],\n\"TreatsInfusion\": [],\n\"TreatsOintment\": [],\n\"Habitat\": [],\n\"Sections\": [],\n\"References\": []\n}" commonName latinName imageName
            (jsonText, imageName, fullImageDownloadFile))
    |> Seq.fold
        (fun totalText (fullText, imageName, downloadFile) ->
//            File.Copy(downloadFile, "/Users/oliversamson/Documents/TheHerbalEscape/Assets/Plants/" + imageName + ".jpg")
            if totalText = "" then fullText else totalText + ",\n" + fullText)
        ""
File.WriteAllText("/Users/oliversamson/Documents/TheHerbalEscape/plants.json", "[\n" + text + "\n]\n")
