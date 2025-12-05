C-Mini Compiler (Final Version)

Bu proje, Compiler Design dersi kapsamında geliştirilmiş; Lexer, Parser, Semantik Analiz ve Kod Üretimi aşamalarının tamamını içeren uçtan uca bir derleyicidir. C dilinin bir alt kümesini (Mini-C) girdi olarak alır ve LLVM IR kodu üretir.

📋 Özellikler

Lexical Analysis (Flex): Anahtar kelimeler (int, float, bool, if, else), operatörler ve tanımlayıcılar tanınır.

Syntax Analysis (Bison): Gramer kuralları kontrol edilir ve Soyut Sözdizimi Ağacı (AST) oluşturulur.

Semantic Analysis:

Değişkenlerin Sembol Tablosu (Symbol Table) üzerinde takibi.

Tanımlanmamış değişken (Undeclared variable) hatası yakalama.

Değişken tekrarı (Redeclaration) hatası yakalama.

Tip uyuşmazlığı (Type Mismatch) kontrolü (Örn: int'e string atama).

Code Generation (LLVM IR):

Tüm değişkenler stack üzerinde (alloca) saklanır.

Matematiksel işlemler (+, -, *, /) desteklenir.

Karmaşık If-Else yapıları br (branch) ve label (etiket) kullanılarak derlenir.

🛠 Gereksinimler

GCC

Flex

Bison

🚀 Kurulum ve Çalıştırma

Terminalde aşağıdaki komutları sırasıyla çalıştırarak derleyiciyi oluşturabilir ve test dosyalarını deneyebilirsiniz:

# 1. Lexer ve Parser kodlarını oluştur
flex clexer.l
bison -d parser.y

# 2. Derleyiciyi oluştur (codegen.c modülü dahil)
gcc lex.yy.c parser.tab.c codegen.c -o mycompiler

# 3. Örnek bir kodu derle (Code Generation Testi)
./mycompiler test_integration.ml > output.ll

# 4. Çıktıyı gör
cat output.ll


📂 Dosya Yapısı

clexer.l: Token tanımları ve Lexer kuralları.

parser.y: Gramer kuralları, AST oluşturma mantığı.

ast.h: Gelişmiş AST düğüm yapıları (elseNode, NODE_MATH vb.).

codegen.c: [Proje 3] Semantik analiz ve LLVM IR kod üretim modülü.

test_*.ml: Proje kapsamında kullanılan test senaryoları.
