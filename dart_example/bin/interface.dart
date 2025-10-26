// Interface

void main() {
  var post = Post('My First Post', 'This is the content of my first post.');
  post.printPost();

  // Only works within the same library (in this case, the same file)
  post._editPost('This is the updated content of my first post.');
}

// Implicit interface example
class Post {
  // public member
  final String title;
  // private member (starts with _), only accessible within the library, but still part of the interface
  String _content;

  // Constructor, not part of the interface
  Post(this.title, this._content);

  // public method, part of the interface
  void printPost() {
    print('Title: $title\nContent: $_content');
  }

  // private method, part of the interface, only accessible from within the library
  void _editPost(String newContent) {
    // Private method (starts with _)
    print('Editing post...');
    _content = newContent;
  }
}
