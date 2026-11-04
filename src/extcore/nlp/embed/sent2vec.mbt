///|
///===
/// extcore/nlp_embed_sent2vec
pub(all) struct Nlpembedsent2vecPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn nlp_embed_sent2vec_make_point(
  x : Double,
  y : Double,
) -> Nlpembedsent2vecPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn nlp_embed_sent2vec_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> Nlpembedsent2vecPoint {
  { x, y, z, label: 0, }
}

///|
pub fn Nlpembedsent2vecPoint::x(self : Nlpembedsent2vecPoint) -> Double {
  self.x
}

///|
pub fn Nlpembedsent2vecPoint::y(self : Nlpembedsent2vecPoint) -> Double {
  self.y
}

///|
pub fn Nlpembedsent2vecPoint::z(self : Nlpembedsent2vecPoint) -> Double {
  self.z
}

///|
pub fn Nlpembedsent2vecPoint::label(self : Nlpembedsent2vecPoint) -> Int32 {
  self.label
}

///|
pub fn Nlpembedsent2vecPoint::dist(
  self : Nlpembedsent2vecPoint,
  other : Nlpembedsent2vecPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn Nlpembedsent2vecPoint::add(
  self : Nlpembedsent2vecPoint,
  other : Nlpembedsent2vecPoint,
) -> Nlpembedsent2vecPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn Nlpembedsent2vecPoint::sub(
  self : Nlpembedsent2vecPoint,
  other : Nlpembedsent2vecPoint,
) -> Nlpembedsent2vecPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn Nlpembedsent2vecPoint::scale(
  self : Nlpembedsent2vecPoint,
  s : Double,
) -> Nlpembedsent2vecPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn Nlpembedsent2vecPoint::dot(
  self : Nlpembedsent2vecPoint,
  other : Nlpembedsent2vecPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn Nlpembedsent2vecPoint::cross(
  self : Nlpembedsent2vecPoint,
  other : Nlpembedsent2vecPoint,
) -> Nlpembedsent2vecPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn Nlpembedsent2vecPoint::norm(self : Nlpembedsent2vecPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn Nlpembedsent2vecPoint::normalize(
  self : Nlpembedsent2vecPoint,
) -> Nlpembedsent2vecPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn Nlpembedsent2vecPoint::negate(
  self : Nlpembedsent2vecPoint,
) -> Nlpembedsent2vecPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn Nlpembedsent2vecPoint::mid(
  self : Nlpembedsent2vecPoint,
  other : Nlpembedsent2vecPoint,
) -> Nlpembedsent2vecPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn Nlpembedsent2vecPoint::lerp(
  self : Nlpembedsent2vecPoint,
  other : Nlpembedsent2vecPoint,
  t : Double,
) -> Nlpembedsent2vecPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn Nlpembedsent2vecPoint::to_string(self : Nlpembedsent2vecPoint) -> String {
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
pub(all) struct Nlpembedsent2vecSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn nlp_embed_sent2vec_make_series(
  vals : Array[Double],
  name : String,
) -> Nlpembedsent2vecSeries {
  { vals, name, meta: 0, }
}

///|
pub fn Nlpembedsent2vecSeries::len(self : Nlpembedsent2vecSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn Nlpembedsent2vecSeries::sum(self : Nlpembedsent2vecSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn Nlpembedsent2vecSeries::mean(self : Nlpembedsent2vecSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn Nlpembedsent2vecSeries::min(self : Nlpembedsent2vecSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn Nlpembedsent2vecSeries::max(self : Nlpembedsent2vecSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn Nlpembedsent2vecSeries::range(self : Nlpembedsent2vecSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn Nlpembedsent2vecSeries::variance(
  self : Nlpembedsent2vecSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn Nlpembedsent2vecSeries::std(self : Nlpembedsent2vecSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn Nlpembedsent2vecSeries::median(self : Nlpembedsent2vecSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn Nlpembedsent2vecSeries::scale(
  self : Nlpembedsent2vecSeries,
  f : Double,
) -> Nlpembedsent2vecSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn Nlpembedsent2vecSeries::add(
  self : Nlpembedsent2vecSeries,
  other : Nlpembedsent2vecSeries,
) -> Nlpembedsent2vecSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn Nlpembedsent2vecSeries::sub(
  self : Nlpembedsent2vecSeries,
  other : Nlpembedsent2vecSeries,
) -> Nlpembedsent2vecSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn Nlpembedsent2vecSeries::normalize(
  self : Nlpembedsent2vecSeries,
) -> Nlpembedsent2vecSeries {
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
pub fn Nlpembedsent2vecSeries::cumsum(
  self : Nlpembedsent2vecSeries,
) -> Nlpembedsent2vecSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn Nlpembedsent2vecSeries::to_string(
  self : Nlpembedsent2vecSeries,
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
pub(all) struct Nlpembedsent2vecMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn nlp_embed_sent2vec_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> Nlpembedsent2vecMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn nlp_embed_sent2vec_matrix_identity(n : Int32) -> Nlpembedsent2vecMatrix {
  let m = nlp_embed_sent2vec_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn Nlpembedsent2vecMatrix::get(
  self : Nlpembedsent2vecMatrix,
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
pub fn Nlpembedsent2vecMatrix::transpose(
  self : Nlpembedsent2vecMatrix,
) -> Nlpembedsent2vecMatrix {
  let result = nlp_embed_sent2vec_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn Nlpembedsent2vecMatrix::add(
  self : Nlpembedsent2vecMatrix,
  other : Nlpembedsent2vecMatrix,
) -> Nlpembedsent2vecMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = nlp_embed_sent2vec_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn Nlpembedsent2vecMatrix::scale(
  self : Nlpembedsent2vecMatrix,
  s : Double,
) -> Nlpembedsent2vecMatrix {
  let result = nlp_embed_sent2vec_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn Nlpembedsent2vecMatrix::multiply(
  self : Nlpembedsent2vecMatrix,
  other : Nlpembedsent2vecMatrix,
) -> Nlpembedsent2vecMatrix {
  if self.cols != other.rows {
    return nlp_embed_sent2vec_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = nlp_embed_sent2vec_make_matrix(self.rows, other.cols, 0.0)
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
pub fn Nlpembedsent2vecMatrix::trace(self : Nlpembedsent2vecMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn Nlpembedsent2vecMatrix::det(self : Nlpembedsent2vecMatrix) -> Double {
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
pub fn Nlpembedsent2vecMatrix::norm(self : Nlpembedsent2vecMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn Nlpembedsent2vecMatrix::to_string(
  self : Nlpembedsent2vecMatrix,
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
pub(all) struct Nlpembedsent2vecVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn nlp_embed_sent2vec_make_vector(
  comps : Array[Double],
) -> Nlpembedsent2vecVector {
  { comps, dim: comps.length(), }
}

///|
pub fn nlp_embed_sent2vec_vector_zero(dim : Int32) -> Nlpembedsent2vecVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn Nlpembedsent2vecVector::add(
  self : Nlpembedsent2vecVector,
  other : Nlpembedsent2vecVector,
) -> Nlpembedsent2vecVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn Nlpembedsent2vecVector::sub(
  self : Nlpembedsent2vecVector,
  other : Nlpembedsent2vecVector,
) -> Nlpembedsent2vecVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn Nlpembedsent2vecVector::scale(
  self : Nlpembedsent2vecVector,
  s : Double,
) -> Nlpembedsent2vecVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn Nlpembedsent2vecVector::dot(
  self : Nlpembedsent2vecVector,
  other : Nlpembedsent2vecVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn Nlpembedsent2vecVector::norm(self : Nlpembedsent2vecVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn Nlpembedsent2vecVector::normalize(
  self : Nlpembedsent2vecVector,
) -> Nlpembedsent2vecVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn Nlpembedsent2vecVector::dist(
  self : Nlpembedsent2vecVector,
  other : Nlpembedsent2vecVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn Nlpembedsent2vecVector::to_string(
  self : Nlpembedsent2vecVector,
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
pub(all) struct Nlpembedsent2vecFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_embed_sent2vec_frame_make(size : Int32) -> Nlpembedsent2vecFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Nlpembedsent2vecFrame::len(self : Nlpembedsent2vecFrame) -> Int32 {
  self.size
}

///|
pub fn Nlpembedsent2vecFrame::get(
  self : Nlpembedsent2vecFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Nlpembedsent2vecFrame::set(
  self : Nlpembedsent2vecFrame,
  i : Int32,
  v : Double,
) -> Nlpembedsent2vecFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedsent2vecFrame::sum(self : Nlpembedsent2vecFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Nlpembedsent2vecFrame::mean(self : Nlpembedsent2vecFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Nlpembedsent2vecFrame::scale(
  self : Nlpembedsent2vecFrame,
  f : Double,
) -> Nlpembedsent2vecFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedsent2vecFrame::add(
  self : Nlpembedsent2vecFrame,
  other : Nlpembedsent2vecFrame,
) -> Nlpembedsent2vecFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Nlpembedsent2vecFrame::copy(
  self : Nlpembedsent2vecFrame,
) -> Nlpembedsent2vecFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedsent2vecFrame::fill(
  self : Nlpembedsent2vecFrame,
  v : Double,
) -> Nlpembedsent2vecFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedsent2vecFrame::min(self : Nlpembedsent2vecFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn Nlpembedsent2vecFrame::max(self : Nlpembedsent2vecFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn Nlpembedsent2vecFrame::to_string(self : Nlpembedsent2vecFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Nlpembedsent2vecTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_embed_sent2vec_table_make(size : Int32) -> Nlpembedsent2vecTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Nlpembedsent2vecTable::len(self : Nlpembedsent2vecTable) -> Int32 {
  self.size
}

///|
pub fn Nlpembedsent2vecTable::get(
  self : Nlpembedsent2vecTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Nlpembedsent2vecTable::set(
  self : Nlpembedsent2vecTable,
  i : Int32,
  v : Double,
) -> Nlpembedsent2vecTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedsent2vecTable::sum(self : Nlpembedsent2vecTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Nlpembedsent2vecTable::mean(self : Nlpembedsent2vecTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Nlpembedsent2vecTable::scale(
  self : Nlpembedsent2vecTable,
  f : Double,
) -> Nlpembedsent2vecTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedsent2vecTable::add(
  self : Nlpembedsent2vecTable,
  other : Nlpembedsent2vecTable,
) -> Nlpembedsent2vecTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Nlpembedsent2vecTable::copy(
  self : Nlpembedsent2vecTable,
) -> Nlpembedsent2vecTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedsent2vecTable::fill(
  self : Nlpembedsent2vecTable,
  v : Double,
) -> Nlpembedsent2vecTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedsent2vecTable::min(self : Nlpembedsent2vecTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn Nlpembedsent2vecTable::max(self : Nlpembedsent2vecTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn Nlpembedsent2vecTable::to_string(self : Nlpembedsent2vecTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Nlpembedsent2vecGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_embed_sent2vec_graphn_make(size : Int32) -> Nlpembedsent2vecGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Nlpembedsent2vecGraphN::len(self : Nlpembedsent2vecGraphN) -> Int32 {
  self.size
}

///|
pub fn Nlpembedsent2vecGraphN::get(
  self : Nlpembedsent2vecGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Nlpembedsent2vecGraphN::set(
  self : Nlpembedsent2vecGraphN,
  i : Int32,
  v : Double,
) -> Nlpembedsent2vecGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedsent2vecGraphN::sum(self : Nlpembedsent2vecGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Nlpembedsent2vecGraphN::mean(self : Nlpembedsent2vecGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Nlpembedsent2vecGraphN::scale(
  self : Nlpembedsent2vecGraphN,
  f : Double,
) -> Nlpembedsent2vecGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedsent2vecGraphN::add(
  self : Nlpembedsent2vecGraphN,
  other : Nlpembedsent2vecGraphN,
) -> Nlpembedsent2vecGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Nlpembedsent2vecGraphN::copy(
  self : Nlpembedsent2vecGraphN,
) -> Nlpembedsent2vecGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedsent2vecGraphN::fill(
  self : Nlpembedsent2vecGraphN,
  v : Double,
) -> Nlpembedsent2vecGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedsent2vecGraphN::min(self : Nlpembedsent2vecGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn Nlpembedsent2vecGraphN::max(self : Nlpembedsent2vecGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn Nlpembedsent2vecGraphN::to_string(
  self : Nlpembedsent2vecGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Nlpembedsent2vecNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_embed_sent2vec_node_make(size : Int32) -> Nlpembedsent2vecNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Nlpembedsent2vecNode::len(self : Nlpembedsent2vecNode) -> Int32 {
  self.size
}

///|
pub fn Nlpembedsent2vecNode::get(
  self : Nlpembedsent2vecNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Nlpembedsent2vecNode::set(
  self : Nlpembedsent2vecNode,
  i : Int32,
  v : Double,
) -> Nlpembedsent2vecNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedsent2vecNode::sum(self : Nlpembedsent2vecNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Nlpembedsent2vecNode::mean(self : Nlpembedsent2vecNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Nlpembedsent2vecNode::scale(
  self : Nlpembedsent2vecNode,
  f : Double,
) -> Nlpembedsent2vecNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedsent2vecNode::add(
  self : Nlpembedsent2vecNode,
  other : Nlpembedsent2vecNode,
) -> Nlpembedsent2vecNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Nlpembedsent2vecNode::copy(
  self : Nlpembedsent2vecNode,
) -> Nlpembedsent2vecNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedsent2vecNode::fill(
  self : Nlpembedsent2vecNode,
  v : Double,
) -> Nlpembedsent2vecNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedsent2vecNode::min(self : Nlpembedsent2vecNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn Nlpembedsent2vecNode::max(self : Nlpembedsent2vecNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn Nlpembedsent2vecNode::to_string(self : Nlpembedsent2vecNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Nlpembedsent2vecEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_embed_sent2vec_edge_make(size : Int32) -> Nlpembedsent2vecEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Nlpembedsent2vecEdge::len(self : Nlpembedsent2vecEdge) -> Int32 {
  self.size
}

///|
pub fn Nlpembedsent2vecEdge::get(
  self : Nlpembedsent2vecEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Nlpembedsent2vecEdge::set(
  self : Nlpembedsent2vecEdge,
  i : Int32,
  v : Double,
) -> Nlpembedsent2vecEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedsent2vecEdge::sum(self : Nlpembedsent2vecEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Nlpembedsent2vecEdge::mean(self : Nlpembedsent2vecEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Nlpembedsent2vecEdge::scale(
  self : Nlpembedsent2vecEdge,
  f : Double,
) -> Nlpembedsent2vecEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedsent2vecEdge::add(
  self : Nlpembedsent2vecEdge,
  other : Nlpembedsent2vecEdge,
) -> Nlpembedsent2vecEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Nlpembedsent2vecEdge::copy(
  self : Nlpembedsent2vecEdge,
) -> Nlpembedsent2vecEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedsent2vecEdge::fill(
  self : Nlpembedsent2vecEdge,
  v : Double,
) -> Nlpembedsent2vecEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedsent2vecEdge::min(self : Nlpembedsent2vecEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn Nlpembedsent2vecEdge::max(self : Nlpembedsent2vecEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn Nlpembedsent2vecEdge::to_string(self : Nlpembedsent2vecEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Nlpembedsent2vecPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_embed_sent2vec_path_make(size : Int32) -> Nlpembedsent2vecPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Nlpembedsent2vecPath::len(self : Nlpembedsent2vecPath) -> Int32 {
  self.size
}

///|
pub fn Nlpembedsent2vecPath::get(
  self : Nlpembedsent2vecPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Nlpembedsent2vecPath::set(
  self : Nlpembedsent2vecPath,
  i : Int32,
  v : Double,
) -> Nlpembedsent2vecPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedsent2vecPath::sum(self : Nlpembedsent2vecPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Nlpembedsent2vecPath::mean(self : Nlpembedsent2vecPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Nlpembedsent2vecPath::scale(
  self : Nlpembedsent2vecPath,
  f : Double,
) -> Nlpembedsent2vecPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedsent2vecPath::add(
  self : Nlpembedsent2vecPath,
  other : Nlpembedsent2vecPath,
) -> Nlpembedsent2vecPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Nlpembedsent2vecPath::copy(
  self : Nlpembedsent2vecPath,
) -> Nlpembedsent2vecPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedsent2vecPath::fill(
  self : Nlpembedsent2vecPath,
  v : Double,
) -> Nlpembedsent2vecPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedsent2vecPath::min(self : Nlpembedsent2vecPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn Nlpembedsent2vecPath::max(self : Nlpembedsent2vecPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn Nlpembedsent2vecPath::to_string(self : Nlpembedsent2vecPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Nlpembedsent2vecCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_embed_sent2vec_cluster_make(size : Int32) -> Nlpembedsent2vecCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Nlpembedsent2vecCluster::len(self : Nlpembedsent2vecCluster) -> Int32 {
  self.size
}

///|
pub fn Nlpembedsent2vecCluster::get(
  self : Nlpembedsent2vecCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Nlpembedsent2vecCluster::set(
  self : Nlpembedsent2vecCluster,
  i : Int32,
  v : Double,
) -> Nlpembedsent2vecCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedsent2vecCluster::sum(self : Nlpembedsent2vecCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Nlpembedsent2vecCluster::mean(self : Nlpembedsent2vecCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Nlpembedsent2vecCluster::scale(
  self : Nlpembedsent2vecCluster,
  f : Double,
) -> Nlpembedsent2vecCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedsent2vecCluster::add(
  self : Nlpembedsent2vecCluster,
  other : Nlpembedsent2vecCluster,
) -> Nlpembedsent2vecCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Nlpembedsent2vecCluster::copy(
  self : Nlpembedsent2vecCluster,
) -> Nlpembedsent2vecCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedsent2vecCluster::fill(
  self : Nlpembedsent2vecCluster,
  v : Double,
) -> Nlpembedsent2vecCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedsent2vecCluster::min(self : Nlpembedsent2vecCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn Nlpembedsent2vecCluster::max(self : Nlpembedsent2vecCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn Nlpembedsent2vecCluster::to_string(
  self : Nlpembedsent2vecCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Nlpembedsent2vecModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_embed_sent2vec_model_make(size : Int32) -> Nlpembedsent2vecModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Nlpembedsent2vecModel::len(self : Nlpembedsent2vecModel) -> Int32 {
  self.size
}

///|
pub fn Nlpembedsent2vecModel::get(
  self : Nlpembedsent2vecModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Nlpembedsent2vecModel::set(
  self : Nlpembedsent2vecModel,
  i : Int32,
  v : Double,
) -> Nlpembedsent2vecModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedsent2vecModel::sum(self : Nlpembedsent2vecModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Nlpembedsent2vecModel::mean(self : Nlpembedsent2vecModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Nlpembedsent2vecModel::scale(
  self : Nlpembedsent2vecModel,
  f : Double,
) -> Nlpembedsent2vecModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedsent2vecModel::add(
  self : Nlpembedsent2vecModel,
  other : Nlpembedsent2vecModel,
) -> Nlpembedsent2vecModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Nlpembedsent2vecModel::copy(
  self : Nlpembedsent2vecModel,
) -> Nlpembedsent2vecModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedsent2vecModel::fill(
  self : Nlpembedsent2vecModel,
  v : Double,
) -> Nlpembedsent2vecModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedsent2vecModel::min(self : Nlpembedsent2vecModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn Nlpembedsent2vecModel::max(self : Nlpembedsent2vecModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn Nlpembedsent2vecModel::to_string(self : Nlpembedsent2vecModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Nlpembedsent2vecLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_embed_sent2vec_layer_make(size : Int32) -> Nlpembedsent2vecLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Nlpembedsent2vecLayer::len(self : Nlpembedsent2vecLayer) -> Int32 {
  self.size
}

///|
pub fn Nlpembedsent2vecLayer::get(
  self : Nlpembedsent2vecLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Nlpembedsent2vecLayer::set(
  self : Nlpembedsent2vecLayer,
  i : Int32,
  v : Double,
) -> Nlpembedsent2vecLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedsent2vecLayer::sum(self : Nlpembedsent2vecLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Nlpembedsent2vecLayer::mean(self : Nlpembedsent2vecLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Nlpembedsent2vecLayer::scale(
  self : Nlpembedsent2vecLayer,
  f : Double,
) -> Nlpembedsent2vecLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedsent2vecLayer::add(
  self : Nlpembedsent2vecLayer,
  other : Nlpembedsent2vecLayer,
) -> Nlpembedsent2vecLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Nlpembedsent2vecLayer::copy(
  self : Nlpembedsent2vecLayer,
) -> Nlpembedsent2vecLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedsent2vecLayer::fill(
  self : Nlpembedsent2vecLayer,
  v : Double,
) -> Nlpembedsent2vecLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedsent2vecLayer::min(self : Nlpembedsent2vecLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn Nlpembedsent2vecLayer::max(self : Nlpembedsent2vecLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn Nlpembedsent2vecLayer::to_string(self : Nlpembedsent2vecLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Nlpembedsent2vecBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_embed_sent2vec_buffer_make(size : Int32) -> Nlpembedsent2vecBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Nlpembedsent2vecBuffer::len(self : Nlpembedsent2vecBuffer) -> Int32 {
  self.size
}

///|
pub fn Nlpembedsent2vecBuffer::get(
  self : Nlpembedsent2vecBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Nlpembedsent2vecBuffer::set(
  self : Nlpembedsent2vecBuffer,
  i : Int32,
  v : Double,
) -> Nlpembedsent2vecBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedsent2vecBuffer::sum(self : Nlpembedsent2vecBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Nlpembedsent2vecBuffer::mean(self : Nlpembedsent2vecBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Nlpembedsent2vecBuffer::scale(
  self : Nlpembedsent2vecBuffer,
  f : Double,
) -> Nlpembedsent2vecBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedsent2vecBuffer::add(
  self : Nlpembedsent2vecBuffer,
  other : Nlpembedsent2vecBuffer,
) -> Nlpembedsent2vecBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Nlpembedsent2vecBuffer::copy(
  self : Nlpembedsent2vecBuffer,
) -> Nlpembedsent2vecBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedsent2vecBuffer::fill(
  self : Nlpembedsent2vecBuffer,
  v : Double,
) -> Nlpembedsent2vecBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedsent2vecBuffer::min(self : Nlpembedsent2vecBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn Nlpembedsent2vecBuffer::max(self : Nlpembedsent2vecBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn Nlpembedsent2vecBuffer::to_string(
  self : Nlpembedsent2vecBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Nlpembedsent2vecCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_embed_sent2vec_cursor_make(size : Int32) -> Nlpembedsent2vecCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Nlpembedsent2vecCursor::len(self : Nlpembedsent2vecCursor) -> Int32 {
  self.size
}

///|
pub fn Nlpembedsent2vecCursor::get(
  self : Nlpembedsent2vecCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Nlpembedsent2vecCursor::set(
  self : Nlpembedsent2vecCursor,
  i : Int32,
  v : Double,
) -> Nlpembedsent2vecCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedsent2vecCursor::sum(self : Nlpembedsent2vecCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Nlpembedsent2vecCursor::mean(self : Nlpembedsent2vecCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Nlpembedsent2vecCursor::scale(
  self : Nlpembedsent2vecCursor,
  f : Double,
) -> Nlpembedsent2vecCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedsent2vecCursor::add(
  self : Nlpembedsent2vecCursor,
  other : Nlpembedsent2vecCursor,
) -> Nlpembedsent2vecCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Nlpembedsent2vecCursor::copy(
  self : Nlpembedsent2vecCursor,
) -> Nlpembedsent2vecCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedsent2vecCursor::fill(
  self : Nlpembedsent2vecCursor,
  v : Double,
) -> Nlpembedsent2vecCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedsent2vecCursor::min(self : Nlpembedsent2vecCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn Nlpembedsent2vecCursor::max(self : Nlpembedsent2vecCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn Nlpembedsent2vecCursor::to_string(
  self : Nlpembedsent2vecCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Nlpembedsent2vecView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_embed_sent2vec_view_make(size : Int32) -> Nlpembedsent2vecView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Nlpembedsent2vecView::len(self : Nlpembedsent2vecView) -> Int32 {
  self.size
}

///|
pub fn Nlpembedsent2vecView::get(
  self : Nlpembedsent2vecView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Nlpembedsent2vecView::set(
  self : Nlpembedsent2vecView,
  i : Int32,
  v : Double,
) -> Nlpembedsent2vecView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedsent2vecView::sum(self : Nlpembedsent2vecView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Nlpembedsent2vecView::mean(self : Nlpembedsent2vecView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Nlpembedsent2vecView::scale(
  self : Nlpembedsent2vecView,
  f : Double,
) -> Nlpembedsent2vecView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedsent2vecView::add(
  self : Nlpembedsent2vecView,
  other : Nlpembedsent2vecView,
) -> Nlpembedsent2vecView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Nlpembedsent2vecView::copy(
  self : Nlpembedsent2vecView,
) -> Nlpembedsent2vecView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedsent2vecView::fill(
  self : Nlpembedsent2vecView,
  v : Double,
) -> Nlpembedsent2vecView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedsent2vecView::min(self : Nlpembedsent2vecView) -> Double {
  @_common.min(self.data)
}

///|
pub fn Nlpembedsent2vecView::max(self : Nlpembedsent2vecView) -> Double {
  @_common.max(self.data)
}

///|
pub fn Nlpembedsent2vecView::to_string(self : Nlpembedsent2vecView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Nlpembedsent2vecRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_embed_sent2vec_range_make(size : Int32) -> Nlpembedsent2vecRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Nlpembedsent2vecRange::len(self : Nlpembedsent2vecRange) -> Int32 {
  self.size
}

///|
pub fn Nlpembedsent2vecRange::get(
  self : Nlpembedsent2vecRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Nlpembedsent2vecRange::set(
  self : Nlpembedsent2vecRange,
  i : Int32,
  v : Double,
) -> Nlpembedsent2vecRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedsent2vecRange::sum(self : Nlpembedsent2vecRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Nlpembedsent2vecRange::mean(self : Nlpembedsent2vecRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Nlpembedsent2vecRange::scale(
  self : Nlpembedsent2vecRange,
  f : Double,
) -> Nlpembedsent2vecRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedsent2vecRange::add(
  self : Nlpembedsent2vecRange,
  other : Nlpembedsent2vecRange,
) -> Nlpembedsent2vecRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Nlpembedsent2vecRange::copy(
  self : Nlpembedsent2vecRange,
) -> Nlpembedsent2vecRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedsent2vecRange::fill(
  self : Nlpembedsent2vecRange,
  v : Double,
) -> Nlpembedsent2vecRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedsent2vecRange::min(self : Nlpembedsent2vecRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn Nlpembedsent2vecRange::max(self : Nlpembedsent2vecRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn Nlpembedsent2vecRange::to_string(self : Nlpembedsent2vecRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Nlpembedsent2vecSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_embed_sent2vec_slice_make(size : Int32) -> Nlpembedsent2vecSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Nlpembedsent2vecSlice::len(self : Nlpembedsent2vecSlice) -> Int32 {
  self.size
}

///|
pub fn Nlpembedsent2vecSlice::get(
  self : Nlpembedsent2vecSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Nlpembedsent2vecSlice::set(
  self : Nlpembedsent2vecSlice,
  i : Int32,
  v : Double,
) -> Nlpembedsent2vecSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedsent2vecSlice::sum(self : Nlpembedsent2vecSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Nlpembedsent2vecSlice::mean(self : Nlpembedsent2vecSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Nlpembedsent2vecSlice::scale(
  self : Nlpembedsent2vecSlice,
  f : Double,
) -> Nlpembedsent2vecSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedsent2vecSlice::add(
  self : Nlpembedsent2vecSlice,
  other : Nlpembedsent2vecSlice,
) -> Nlpembedsent2vecSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Nlpembedsent2vecSlice::copy(
  self : Nlpembedsent2vecSlice,
) -> Nlpembedsent2vecSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedsent2vecSlice::fill(
  self : Nlpembedsent2vecSlice,
  v : Double,
) -> Nlpembedsent2vecSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Nlpembedsent2vecSlice::min(self : Nlpembedsent2vecSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn Nlpembedsent2vecSlice::max(self : Nlpembedsent2vecSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn Nlpembedsent2vecSlice::to_string(self : Nlpembedsent2vecSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
