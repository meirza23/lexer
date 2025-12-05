# **C-Mini Compiler – Final Version**

Bu proje, *Compiler Design* dersi kapsamında geliştirilmiş uçtan uca bir derleyicidir. Mini-C olarak adlandırılan C dilinin bir alt kümesini girdi olarak alır; Lexical Analysis, Syntax Analysis, Semantik Analiz ve Code Generation aşamalarından geçirerek LLVM IR çıktısı üretir.

---

## 📌 **Özellikler**

### **1. Lexical Analysis (Flex)**
- `int`, `float`, `bool`, `if`, `else` gibi anahtar kelimeleri tanır.
- Operatörleri, literal değerleri ve tanımlayıcıları ayıklar.

### **2. Syntax Analysis (Bison)**
- Gramer kurallarına göre Mini-C kodunu parse eder.
- Soyut Sözdizimi Ağacı (AST) oluşturur.

### **3. Semantic Analysis**
- Değişkenlerin sembol tablosunda yönetimi.
- Tanımlanmamış değişken kullanımı tespiti.
- Değişken tekrar tanımlama (redeclaration) hatası kontrolü.
- Tip uyuşmazlığı (type mismatch) tespiti.

### **4. Code Generation (LLVM IR)**
- Tüm değişkenler `alloca` ile stack üzerinde tutulur.
- Aritmetik işlemler (`+`, `-`, `*`, `/`) desteklenir.
- If-Else yapıları `br` (branch) ve `label` kullanılarak derlenir.

---

## 🛠 **Gereksinimler**

- GCC  
- Flex  
- Bison  
- (İsteğe bağlı) LLVM → Üretilen IR'ı çalıştırmak için

---

## 🚀 **Kurulum ve Çalıştırma**

### **1. Lexer ve Parser kodlarını üretin**
```bash
flex clexer.l
bison -d parser.y
```

### **2. Derleyiciyi derleyin**
```bash
gcc lex.yy.c parser.tab.c codegen.c -o mycompiler
```

### **3. Örnek bir Mini-C kodunu derleyin**
```bash
./mycompiler test_integration.ml > output.ll
```

### **4. LLVM IR çıktısını görüntüleyin**
```bash
cat output.ll
```

---

## 📂 **Dosya Yapısı**

```
clexer.l               → Lexer kuralları  
parser.y               → Bison grameri + AST üretimi  
ast.h                  → AST düğüm yapıları  
codegen.c              → Semantik analiz + LLVM IR üretimi  
test_*.ml              → Test senaryoları  
```

---

## 🧪 **Test Dosyalarının Çalıştırılması**

### **1. Code Generation Testi – test_codegen.ml**
```bash
./mycompiler test_codegen.ml > codegen.ll
cat codegen.ll
```

### **2. Entegrasyon Testi – test_integration.ml**
```bash
./mycompiler test_integration.ml > integration.ll
cat integration.ll
```

---

## ❗ **Semantik Hata Testleri**

### **test_semantic_err1.ml**  
*Tanımlanmamış değişken testi*
```bash
./mycompiler test_semantic_err1.ml
```

### **test_semantic_err2.ml**  
*Değişken tekrar tanımlama testi*
```bash
./mycompiler test_semantic_err2.ml
```

### **test_semantic_err3.ml**  
*Tip uyuşmazlığı testi*
```bash
./mycompiler test_semantic_err3.ml
```

---

## ✔ **Geçerli Kod Testi**

### **test_semantic_valid.ml**
```bash
./mycompiler test_semantic_valid.ml > semantic_valid.ll
cat semantic_valid.ll
```

---

## 🎯 **Sonuç**

Bu proje, Mini-C dilini uçtan uca işleyip LLVM IR çıktısı üretebilen tam bir derleyici prototipidir.  
Eğitim amaçlıdır ve gerçek bir derleyicinin çalışma adımlarını öğrenmek için uygundur.
