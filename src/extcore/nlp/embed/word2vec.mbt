///|
///===
/// extcore/nlp_embed_word2vec
pub(all) struct Nlpembedword2vecPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn nlp_embed_word2vec_make_point(
  x : Double,
  y : Double,
) -> Nlpembedword2vecPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn nlp_embed_word2vec_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> Nlpembedword2vecPoint {
  { x, y, z, label: 0, }
}

///|
pub fn Nlpembedword2vecPoint::x(self : Nlpembedword2vecPoint) -> Double {
  self.x
}

///|
pub fn Nlpembedword2vecPoint::y(self : Nlpembedword2vecPoint) -> Double {
  self.y
}

///|
pub fn Nlpembedword2vecPoint::z(self : Nlpembedword2vecPoint) -> Double {
  self.z
}

///|
pub fn Nlpembedword2vecPoint::label(self : Nlpembedword2vecPoint) -> Int32 {
  self.label
}

///|
pub fn Nlpembedword2vecPoint::dist(
  self : Nlpembedword2vecPoint,
  other : Nlpembedword2vecPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn Nlpembedword2vecPoint::add(
  self : Nlpembedword2vecPoint,
  other : Nlpembedword2vecPoint,
) -> Nlpembedword2vecPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn Nlpembedword2vecPoint::sub(
  self : Nlpembedword2vecPoint,
  other : Nlpembedword2vecPoint,
) -> Nlpembedword2vecPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn Nlpembedword2vecPoint::scale(
  self : Nlpembedword2vecPoint,
  s : Double,
) -> Nlpembedword2vecPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn Nlpembedword2vecPoint::dot(
  self : Nlpembedword2vecPoint,
  other : Nlpembedword2vecPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn Nlpembedword2vecPoint::cross(
  self : Nlpembedword2vecPoint,
  other : Nlpembedword2vecPoint,
) -> Nlpembedword2vecPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn Nlpembedword2vecPoint::norm(self : Nlpembedword2vecPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn Nlpembedword2vecPoint::normalize(
  self : Nlpembedword2vecPoint,
) -> Nlpembedword2vecPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn Nlpembedword2vecPoint::negate(
  self : Nlpembedword2vecPoint,
) -> Nlpembedword2vecPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn Nlpembedword2vecPoint::mid(
  self : Nlpembedword2vecPoint,
  other : Nlpembedword2vecPoint,
) -> Nlpembedword2vecPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn Nlpembedword2vecPoint::lerp(
  self : Nlpembedword2vecPoint,
  other : Nlpembedword2vecPoint,
  t : Double,
) -> Nlpembedword2vecPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn Nlpembedword2vecPoint::to_string(self : Nlpembedword2vecPoint) -> String {
  "(" +
  @_common.dbl(self.x) +
  ", " +
  @_common.dbl(self.y) +
  ", " +
  @_common.dbl(self.z) +
  ")[" +
  self.label.to_string() +
  "]"
}

///|
pub(all) struct Nlpembedword2vecSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn nlp_embed_word2vec_make_series(
  vals : Array[Double],
  name : String,
) -> Nlpembedword2vecSeries {
  { vals, name, meta: 0, }
}

///|
pub fn Nlpembedword2vecSeries::len(self : Nlpembedword2vecSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn Nlpembedword2vecSeries::sum(self : Nlpembedword2vecSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn Nlpembedword2vecSeries::mean(self : Nlpembedword2vecSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn Nlpembedword2vecSeries::min(self : Nlpembedword2vecSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn Nlpembedword2vecSeries::max(self : Nlpembedword2vecSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn Nlpembedword2vecSeries::range(self : Nlpembedword2vecSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn Nlpembedword2vecSeries::variance(
  self : Nlpembedword2vecSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn Nlpembedword2vecSeries::std(self : Nlpembedword2vecSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn Nlpembedword2vecSeries::median(self : Nlpembedword2vecSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn Nlpembedword2vecSeries::scale(
  self : Nlpembedword2vecSeries,
  f : Double,
) -> Nlpembedword2vecSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn Nlpembedword2vecSeries::add(
  self : Nlpembedword2vecSeries,
  other : Nlpembedword2vecSeries,
) -> Nlpembedword2vecSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn Nlpembedword2vecSeries::sub(
  self : Nlpembedword2vecSeries,
  other : Nlpembedword2vecSeries,
) -> Nlpembedword2vecSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn Nlpembedword2vecSeries::normalize(
  self : Nlpembedword2vecSeries,
) -> Nlpembedword2vecSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 {
    self
  } else {
    let result = []
    for i in 0..<self.vals.length() {
      result.push((self.vals[i] - mn) / r)
    }
    { vals: result, name: self.name, meta: self.meta, }
  }
}

///|
pub fn Nlpembedword2vecSeries::cumsum(
  self : Nlpembedword2vecSeries,
) -> Nlpembedword2vecSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn Nlpembedword2vecSeries::to_string(
  self : Nlpembedword2vecSeries,
) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim {
    if i > 0 {
      result = result + ", "
    }
    result = result + @_common.dbl(self.vals[i])
  }
  if n > 10 {
    result + "...]"
  } else {
    result + "]"
  }
}

///|
pub(all) struct Nlpembedword2vecMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn nlp_embed_word2vec_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> Nlpembedword2vecMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn nlp_embed_word2vec_matrix_identity(n : Int32) -> Nlpembedword2vecMatrix {
  let m = nlp_embed_word2vec_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn Nlpembedword2vecMatrix::get(
  self : Nlpembedword2vecMatrix,
  i : Int32,
  j : Int32,
) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols {
    0.0
  } else {
    self.data[i][j]
  }
}

///|
pub fn Nlpembedword2vecMatrix::transpose(
  self : Nlpembedword2vecMatrix,
) -> Nlpembedword2vecMatrix {
  let result = nlp_embed_word2vec_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn Nlpembedword2vecMatrix::add(
  self : Nlpembedword2vecMatrix,
  other : Nlpembedword2vecMatrix,
) -> Nlpembedword2vecMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = nlp_embed_word2vec_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn Nlpembedword2vecMatrix::scale(
  self : Nlpembedword2vecMatrix,
  s : Double,
) -> Nlpembedword2vecMatrix {
  let result = nlp_embed_word2vec_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn Nlpembedword2vecMatrix::multiply(
  self : Nlpembedword2vecMatrix,
  other : Nlpembedword2vecMatrix,
) -> Nlpembedword2vecMatrix {
  if self.cols != other.rows {
    return nlp_embed_word2vec_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = nlp_embed_word2vec_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols {
        result.data[i][j] = result.data[i][j] + v * other.data[k][j]
      }
    }
  }
  result
}

///|
pub fn Nlpembedword2vecMatrix::trace(self : Nlpembedword2vecMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn Nlpembedword2vecMatrix::det(self : Nlpembedword2vecMatrix) -> Double {
  if self.rows != self.cols {
    0.0
  } else if self.rows == 1 {
    self.data[0][0]
  } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] *
      (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] *
      (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] *
      (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else {
    0.0
  }
}

///|
pub fn Nlpembedword2vecMatrix::norm(self : Nlpembedword2vecMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn Nlpembedword2vecMatrix::to_string(
  self : Nlpembedword2vecMatrix,
) -> String {
  let mut result = "Mat(" +
    self.rows.to_string() +
    "x" +
    self.cols.to_string() +
    ")\n"
  let rl = if self.rows < 5 { self.rows } else { 5 }
  let cl = if self.cols < 5 { self.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl {
      if j > 0 {
        result = result + ", "
      }
      result = result + @_common.dbl(self.data[i][j])
    }
    result = result + "]\n"
  }
  result
}

///|
pub(all) struct Nlpembedword2vecVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn nlp_embed_word2vec_make_vector(
  comps : Array[Double],
) -> Nlpembedword2vecVector {
  { comps, dim: comps.length(), }
}

///|
pub fn nlp_embed_word2vec_vector_zero(dim : Int32) -> Nlpembedword2vecVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn Nlpembedword2vecVector::add(
  self : Nlpembedword2vecVector,
  other : Nlpembedword2vecVector,
) -> Nlpembedword2vecVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn Nlpembedword2vecVector::sub(
  self : Nlpembedword2vecVector,
  other : Nlpembedword2vecVector,
) -> Nlpembedword2vecVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn Nlpembedword2vecVector::scale(
  self : Nlpembedword2vecVector,
  s : Double,
) -> Nlpembedword2vecVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn Nlpembedword2vecVector::dot(
  self : Nlpembedword2vecVector,
  other : Nlpembedword2vecVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn Nlpembedword2vecVector::norm(self : Nlpembedword2vecVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn Nlpembedword2vecVector::normalize(
  self : Nlpembedword2vecVector,
) -> Nlpembedword2vecVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn Nlpembedword2vecVector::dist(
  self : Nlpembedword2vecVector,
  other : Nlpembedword2vecVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn Nlpembedword2vecVector::to_string(
  self : Nlpembedword2vecVector,
) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim {
    if i > 0 {
      result = result + ", "
    }
    result = result + @_common.dbl(self.comps[i])
  }
  if self.dim > 10 {
    result + "...]"
  } else {
    result + "]"
  }
}

///|
pub(all) struct Nlpembedword2vecFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_embed_word2vec_frame_make(size : Int32) -> Nlpembedword2vecFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Nlpembedword2vecFrame::len(self : Nlpembedword2vecFrame) -> Int32 {
  self.size
}

///|
pub fn Nlpembedword2vecFrame::get(
  self : Nlpembedword2vecFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Nlpembedword2vecFrame::set(
  self : Nlpembedword2vecFrame,
  i : Int32,
  v : Double,
) -> Nlpembedword2vecFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedword2vecFrame::sum(self : Nlpembedword2vecFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Nlpembedword2vecFrame::mean(self : Nlpembedword2vecFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Nlpembedword2vecFrame::scale(
  self : Nlpembedword2vecFrame,
  f : Double,
) -> Nlpembedword2vecFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedword2vecFrame::add(
  self : Nlpembedword2vecFrame,
  other : Nlpembedword2vecFrame,
) -> Nlpembedword2vecFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Nlpembedword2vecFrame::copy(
  self : Nlpembedword2vecFrame,
) -> Nlpembedword2vecFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedword2vecFrame::fill(
  self : Nlpembedword2vecFrame,
  v : Double,
) -> Nlpembedword2vecFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedword2vecFrame::min(self : Nlpembedword2vecFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn Nlpembedword2vecFrame::max(self : Nlpembedword2vecFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn Nlpembedword2vecFrame::to_string(self : Nlpembedword2vecFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Nlpembedword2vecTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_embed_word2vec_table_make(size : Int32) -> Nlpembedword2vecTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Nlpembedword2vecTable::len(self : Nlpembedword2vecTable) -> Int32 {
  self.size
}

///|
pub fn Nlpembedword2vecTable::get(
  self : Nlpembedword2vecTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Nlpembedword2vecTable::set(
  self : Nlpembedword2vecTable,
  i : Int32,
  v : Double,
) -> Nlpembedword2vecTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedword2vecTable::sum(self : Nlpembedword2vecTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Nlpembedword2vecTable::mean(self : Nlpembedword2vecTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Nlpembedword2vecTable::scale(
  self : Nlpembedword2vecTable,
  f : Double,
) -> Nlpembedword2vecTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedword2vecTable::add(
  self : Nlpembedword2vecTable,
  other : Nlpembedword2vecTable,
) -> Nlpembedword2vecTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Nlpembedword2vecTable::copy(
  self : Nlpembedword2vecTable,
) -> Nlpembedword2vecTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedword2vecTable::fill(
  self : Nlpembedword2vecTable,
  v : Double,
) -> Nlpembedword2vecTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedword2vecTable::min(self : Nlpembedword2vecTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn Nlpembedword2vecTable::max(self : Nlpembedword2vecTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn Nlpembedword2vecTable::to_string(self : Nlpembedword2vecTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Nlpembedword2vecGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_embed_word2vec_graphn_make(size : Int32) -> Nlpembedword2vecGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Nlpembedword2vecGraphN::len(self : Nlpembedword2vecGraphN) -> Int32 {
  self.size
}

///|
pub fn Nlpembedword2vecGraphN::get(
  self : Nlpembedword2vecGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Nlpembedword2vecGraphN::set(
  self : Nlpembedword2vecGraphN,
  i : Int32,
  v : Double,
) -> Nlpembedword2vecGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedword2vecGraphN::sum(self : Nlpembedword2vecGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Nlpembedword2vecGraphN::mean(self : Nlpembedword2vecGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Nlpembedword2vecGraphN::scale(
  self : Nlpembedword2vecGraphN,
  f : Double,
) -> Nlpembedword2vecGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedword2vecGraphN::add(
  self : Nlpembedword2vecGraphN,
  other : Nlpembedword2vecGraphN,
) -> Nlpembedword2vecGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Nlpembedword2vecGraphN::copy(
  self : Nlpembedword2vecGraphN,
) -> Nlpembedword2vecGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedword2vecGraphN::fill(
  self : Nlpembedword2vecGraphN,
  v : Double,
) -> Nlpembedword2vecGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedword2vecGraphN::min(self : Nlpembedword2vecGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn Nlpembedword2vecGraphN::max(self : Nlpembedword2vecGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn Nlpembedword2vecGraphN::to_string(
  self : Nlpembedword2vecGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Nlpembedword2vecNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_embed_word2vec_node_make(size : Int32) -> Nlpembedword2vecNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Nlpembedword2vecNode::len(self : Nlpembedword2vecNode) -> Int32 {
  self.size
}

///|
pub fn Nlpembedword2vecNode::get(
  self : Nlpembedword2vecNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Nlpembedword2vecNode::set(
  self : Nlpembedword2vecNode,
  i : Int32,
  v : Double,
) -> Nlpembedword2vecNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedword2vecNode::sum(self : Nlpembedword2vecNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Nlpembedword2vecNode::mean(self : Nlpembedword2vecNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Nlpembedword2vecNode::scale(
  self : Nlpembedword2vecNode,
  f : Double,
) -> Nlpembedword2vecNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedword2vecNode::add(
  self : Nlpembedword2vecNode,
  other : Nlpembedword2vecNode,
) -> Nlpembedword2vecNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Nlpembedword2vecNode::copy(
  self : Nlpembedword2vecNode,
) -> Nlpembedword2vecNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedword2vecNode::fill(
  self : Nlpembedword2vecNode,
  v : Double,
) -> Nlpembedword2vecNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedword2vecNode::min(self : Nlpembedword2vecNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn Nlpembedword2vecNode::max(self : Nlpembedword2vecNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn Nlpembedword2vecNode::to_string(self : Nlpembedword2vecNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Nlpembedword2vecEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_embed_word2vec_edge_make(size : Int32) -> Nlpembedword2vecEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Nlpembedword2vecEdge::len(self : Nlpembedword2vecEdge) -> Int32 {
  self.size
}

///|
pub fn Nlpembedword2vecEdge::get(
  self : Nlpembedword2vecEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Nlpembedword2vecEdge::set(
  self : Nlpembedword2vecEdge,
  i : Int32,
  v : Double,
) -> Nlpembedword2vecEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedword2vecEdge::sum(self : Nlpembedword2vecEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Nlpembedword2vecEdge::mean(self : Nlpembedword2vecEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Nlpembedword2vecEdge::scale(
  self : Nlpembedword2vecEdge,
  f : Double,
) -> Nlpembedword2vecEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedword2vecEdge::add(
  self : Nlpembedword2vecEdge,
  other : Nlpembedword2vecEdge,
) -> Nlpembedword2vecEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Nlpembedword2vecEdge::copy(
  self : Nlpembedword2vecEdge,
) -> Nlpembedword2vecEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedword2vecEdge::fill(
  self : Nlpembedword2vecEdge,
  v : Double,
) -> Nlpembedword2vecEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedword2vecEdge::min(self : Nlpembedword2vecEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn Nlpembedword2vecEdge::max(self : Nlpembedword2vecEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn Nlpembedword2vecEdge::to_string(self : Nlpembedword2vecEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Nlpembedword2vecPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_embed_word2vec_path_make(size : Int32) -> Nlpembedword2vecPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Nlpembedword2vecPath::len(self : Nlpembedword2vecPath) -> Int32 {
  self.size
}

///|
pub fn Nlpembedword2vecPath::get(
  self : Nlpembedword2vecPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Nlpembedword2vecPath::set(
  self : Nlpembedword2vecPath,
  i : Int32,
  v : Double,
) -> Nlpembedword2vecPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedword2vecPath::sum(self : Nlpembedword2vecPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Nlpembedword2vecPath::mean(self : Nlpembedword2vecPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Nlpembedword2vecPath::scale(
  self : Nlpembedword2vecPath,
  f : Double,
) -> Nlpembedword2vecPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedword2vecPath::add(
  self : Nlpembedword2vecPath,
  other : Nlpembedword2vecPath,
) -> Nlpembedword2vecPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Nlpembedword2vecPath::copy(
  self : Nlpembedword2vecPath,
) -> Nlpembedword2vecPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedword2vecPath::fill(
  self : Nlpembedword2vecPath,
  v : Double,
) -> Nlpembedword2vecPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedword2vecPath::min(self : Nlpembedword2vecPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn Nlpembedword2vecPath::max(self : Nlpembedword2vecPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn Nlpembedword2vecPath::to_string(self : Nlpembedword2vecPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Nlpembedword2vecCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_embed_word2vec_cluster_make(size : Int32) -> Nlpembedword2vecCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Nlpembedword2vecCluster::len(self : Nlpembedword2vecCluster) -> Int32 {
  self.size
}

///|
pub fn Nlpembedword2vecCluster::get(
  self : Nlpembedword2vecCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Nlpembedword2vecCluster::set(
  self : Nlpembedword2vecCluster,
  i : Int32,
  v : Double,
) -> Nlpembedword2vecCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedword2vecCluster::sum(self : Nlpembedword2vecCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Nlpembedword2vecCluster::mean(self : Nlpembedword2vecCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Nlpembedword2vecCluster::scale(
  self : Nlpembedword2vecCluster,
  f : Double,
) -> Nlpembedword2vecCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedword2vecCluster::add(
  self : Nlpembedword2vecCluster,
  other : Nlpembedword2vecCluster,
) -> Nlpembedword2vecCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Nlpembedword2vecCluster::copy(
  self : Nlpembedword2vecCluster,
) -> Nlpembedword2vecCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedword2vecCluster::fill(
  self : Nlpembedword2vecCluster,
  v : Double,
) -> Nlpembedword2vecCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedword2vecCluster::min(self : Nlpembedword2vecCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn Nlpembedword2vecCluster::max(self : Nlpembedword2vecCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn Nlpembedword2vecCluster::to_string(
  self : Nlpembedword2vecCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Nlpembedword2vecModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_embed_word2vec_model_make(size : Int32) -> Nlpembedword2vecModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Nlpembedword2vecModel::len(self : Nlpembedword2vecModel) -> Int32 {
  self.size
}

///|
pub fn Nlpembedword2vecModel::get(
  self : Nlpembedword2vecModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Nlpembedword2vecModel::set(
  self : Nlpembedword2vecModel,
  i : Int32,
  v : Double,
) -> Nlpembedword2vecModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedword2vecModel::sum(self : Nlpembedword2vecModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Nlpembedword2vecModel::mean(self : Nlpembedword2vecModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Nlpembedword2vecModel::scale(
  self : Nlpembedword2vecModel,
  f : Double,
) -> Nlpembedword2vecModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedword2vecModel::add(
  self : Nlpembedword2vecModel,
  other : Nlpembedword2vecModel,
) -> Nlpembedword2vecModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Nlpembedword2vecModel::copy(
  self : Nlpembedword2vecModel,
) -> Nlpembedword2vecModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedword2vecModel::fill(
  self : Nlpembedword2vecModel,
  v : Double,
) -> Nlpembedword2vecModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedword2vecModel::min(self : Nlpembedword2vecModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn Nlpembedword2vecModel::max(self : Nlpembedword2vecModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn Nlpembedword2vecModel::to_string(self : Nlpembedword2vecModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Nlpembedword2vecLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_embed_word2vec_layer_make(size : Int32) -> Nlpembedword2vecLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Nlpembedword2vecLayer::len(self : Nlpembedword2vecLayer) -> Int32 {
  self.size
}

///|
pub fn Nlpembedword2vecLayer::get(
  self : Nlpembedword2vecLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Nlpembedword2vecLayer::set(
  self : Nlpembedword2vecLayer,
  i : Int32,
  v : Double,
) -> Nlpembedword2vecLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedword2vecLayer::sum(self : Nlpembedword2vecLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Nlpembedword2vecLayer::mean(self : Nlpembedword2vecLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Nlpembedword2vecLayer::scale(
  self : Nlpembedword2vecLayer,
  f : Double,
) -> Nlpembedword2vecLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedword2vecLayer::add(
  self : Nlpembedword2vecLayer,
  other : Nlpembedword2vecLayer,
) -> Nlpembedword2vecLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Nlpembedword2vecLayer::copy(
  self : Nlpembedword2vecLayer,
) -> Nlpembedword2vecLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedword2vecLayer::fill(
  self : Nlpembedword2vecLayer,
  v : Double,
) -> Nlpembedword2vecLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedword2vecLayer::min(self : Nlpembedword2vecLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn Nlpembedword2vecLayer::max(self : Nlpembedword2vecLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn Nlpembedword2vecLayer::to_string(self : Nlpembedword2vecLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Nlpembedword2vecBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_embed_word2vec_buffer_make(size : Int32) -> Nlpembedword2vecBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Nlpembedword2vecBuffer::len(self : Nlpembedword2vecBuffer) -> Int32 {
  self.size
}

///|
pub fn Nlpembedword2vecBuffer::get(
  self : Nlpembedword2vecBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Nlpembedword2vecBuffer::set(
  self : Nlpembedword2vecBuffer,
  i : Int32,
  v : Double,
) -> Nlpembedword2vecBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedword2vecBuffer::sum(self : Nlpembedword2vecBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Nlpembedword2vecBuffer::mean(self : Nlpembedword2vecBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Nlpembedword2vecBuffer::scale(
  self : Nlpembedword2vecBuffer,
  f : Double,
) -> Nlpembedword2vecBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedword2vecBuffer::add(
  self : Nlpembedword2vecBuffer,
  other : Nlpembedword2vecBuffer,
) -> Nlpembedword2vecBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Nlpembedword2vecBuffer::copy(
  self : Nlpembedword2vecBuffer,
) -> Nlpembedword2vecBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedword2vecBuffer::fill(
  self : Nlpembedword2vecBuffer,
  v : Double,
) -> Nlpembedword2vecBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedword2vecBuffer::min(self : Nlpembedword2vecBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn Nlpembedword2vecBuffer::max(self : Nlpembedword2vecBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn Nlpembedword2vecBuffer::to_string(
  self : Nlpembedword2vecBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Nlpembedword2vecCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_embed_word2vec_cursor_make(size : Int32) -> Nlpembedword2vecCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Nlpembedword2vecCursor::len(self : Nlpembedword2vecCursor) -> Int32 {
  self.size
}

///|
pub fn Nlpembedword2vecCursor::get(
  self : Nlpembedword2vecCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Nlpembedword2vecCursor::set(
  self : Nlpembedword2vecCursor,
  i : Int32,
  v : Double,
) -> Nlpembedword2vecCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedword2vecCursor::sum(self : Nlpembedword2vecCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Nlpembedword2vecCursor::mean(self : Nlpembedword2vecCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Nlpembedword2vecCursor::scale(
  self : Nlpembedword2vecCursor,
  f : Double,
) -> Nlpembedword2vecCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedword2vecCursor::add(
  self : Nlpembedword2vecCursor,
  other : Nlpembedword2vecCursor,
) -> Nlpembedword2vecCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Nlpembedword2vecCursor::copy(
  self : Nlpembedword2vecCursor,
) -> Nlpembedword2vecCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedword2vecCursor::fill(
  self : Nlpembedword2vecCursor,
  v : Double,
) -> Nlpembedword2vecCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedword2vecCursor::min(self : Nlpembedword2vecCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn Nlpembedword2vecCursor::max(self : Nlpembedword2vecCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn Nlpembedword2vecCursor::to_string(
  self : Nlpembedword2vecCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Nlpembedword2vecView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_embed_word2vec_view_make(size : Int32) -> Nlpembedword2vecView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Nlpembedword2vecView::len(self : Nlpembedword2vecView) -> Int32 {
  self.size
}

///|
pub fn Nlpembedword2vecView::get(
  self : Nlpembedword2vecView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Nlpembedword2vecView::set(
  self : Nlpembedword2vecView,
  i : Int32,
  v : Double,
) -> Nlpembedword2vecView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedword2vecView::sum(self : Nlpembedword2vecView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Nlpembedword2vecView::mean(self : Nlpembedword2vecView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Nlpembedword2vecView::scale(
  self : Nlpembedword2vecView,
  f : Double,
) -> Nlpembedword2vecView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedword2vecView::add(
  self : Nlpembedword2vecView,
  other : Nlpembedword2vecView,
) -> Nlpembedword2vecView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Nlpembedword2vecView::copy(
  self : Nlpembedword2vecView,
) -> Nlpembedword2vecView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedword2vecView::fill(
  self : Nlpembedword2vecView,
  v : Double,
) -> Nlpembedword2vecView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedword2vecView::min(self : Nlpembedword2vecView) -> Double {
  @_common.min(self.data)
}

///|
pub fn Nlpembedword2vecView::max(self : Nlpembedword2vecView) -> Double {
  @_common.max(self.data)
}

///|
pub fn Nlpembedword2vecView::to_string(self : Nlpembedword2vecView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Nlpembedword2vecRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_embed_word2vec_range_make(size : Int32) -> Nlpembedword2vecRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Nlpembedword2vecRange::len(self : Nlpembedword2vecRange) -> Int32 {
  self.size
}

///|
pub fn Nlpembedword2vecRange::get(
  self : Nlpembedword2vecRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Nlpembedword2vecRange::set(
  self : Nlpembedword2vecRange,
  i : Int32,
  v : Double,
) -> Nlpembedword2vecRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedword2vecRange::sum(self : Nlpembedword2vecRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Nlpembedword2vecRange::mean(self : Nlpembedword2vecRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Nlpembedword2vecRange::scale(
  self : Nlpembedword2vecRange,
  f : Double,
) -> Nlpembedword2vecRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedword2vecRange::add(
  self : Nlpembedword2vecRange,
  other : Nlpembedword2vecRange,
) -> Nlpembedword2vecRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Nlpembedword2vecRange::copy(
  self : Nlpembedword2vecRange,
) -> Nlpembedword2vecRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedword2vecRange::fill(
  self : Nlpembedword2vecRange,
  v : Double,
) -> Nlpembedword2vecRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedword2vecRange::min(self : Nlpembedword2vecRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn Nlpembedword2vecRange::max(self : Nlpembedword2vecRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn Nlpembedword2vecRange::to_string(self : Nlpembedword2vecRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Nlpembedword2vecSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_embed_word2vec_slice_make(size : Int32) -> Nlpembedword2vecSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Nlpembedword2vecSlice::len(self : Nlpembedword2vecSlice) -> Int32 {
  self.size
}

///|
pub fn Nlpembedword2vecSlice::get(
  self : Nlpembedword2vecSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Nlpembedword2vecSlice::set(
  self : Nlpembedword2vecSlice,
  i : Int32,
  v : Double,
) -> Nlpembedword2vecSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedword2vecSlice::sum(self : Nlpembedword2vecSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Nlpembedword2vecSlice::mean(self : Nlpembedword2vecSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Nlpembedword2vecSlice::scale(
  self : Nlpembedword2vecSlice,
  f : Double,
) -> Nlpembedword2vecSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedword2vecSlice::add(
  self : Nlpembedword2vecSlice,
  other : Nlpembedword2vecSlice,
) -> Nlpembedword2vecSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Nlpembedword2vecSlice::copy(
  self : Nlpembedword2vecSlice,
) -> Nlpembedword2vecSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedword2vecSlice::fill(
  self : Nlpembedword2vecSlice,
  v : Double,
) -> Nlpembedword2vecSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedword2vecSlice::min(self : Nlpembedword2vecSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn Nlpembedword2vecSlice::max(self : Nlpembedword2vecSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn Nlpembedword2vecSlice::to_string(self : Nlpembedword2vecSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
