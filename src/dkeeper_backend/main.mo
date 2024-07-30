import Text "mo:base/Text";
import List "mo:base/List";
import Debug "mo:base/Debug";
import Nat "mo:base/Nat";

actor DKeeper {
  public type Note = {
    id : Nat;
    title : Text;
    content : Text;
  };

  var notes : List.List<Note> = List.nil<Note>();
  var nextId : Nat = 0;

  public func createNote(titleText : Text, contentText : Text) {
    let newNote : Note = {
      id = nextId;
      title = titleText;
      content = contentText;
    };
    notes := List.push(newNote, notes);
    nextId += 1;
    Debug.print(debug_show (notes));
  };

  public query func readNotes() : async [Note] {
    return List.toArray(notes);
  };

  public func removeNote(id : Nat) {
    let keepNote = func(n : Note) : Bool {
      return n.id != id;
    };
    notes := List.filter(notes, keepNote);
  };
};
