open System
open System.IO
open System.Text.RegularExpressions

/// Some properly hacky stuff to scrape some Plant content.

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
        Some("https://en.wikipedia.org/wiki/List_of_plants_used_in_herbalism#/media/" + (m.Groups.[1].Value.Replace("/wiki/", "")))
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
