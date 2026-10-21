///|
///===
/// extcore/nlp_embed_contrastive
pub(all) struct NlpembedcontrastivePoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn nlp_embed_contrastive_make_point(
  x : Double,
  y : Double,
) -> NlpembedcontrastivePoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn nlp_embed_contrastive_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> NlpembedcontrastivePoint {
  { x, y, z, label: 0, }
}

///|
pub fn NlpembedcontrastivePoint::x(self : NlpembedcontrastivePoint) -> Double {
  self.x
}

///|
pub fn NlpembedcontrastivePoint::y(self : NlpembedcontrastivePoint) -> Double {
  self.y
}

///|
pub fn NlpembedcontrastivePoint::z(self : NlpembedcontrastivePoint) -> Double {
  self.z
}

///|
pub fn NlpembedcontrastivePoint::label(
  self : NlpembedcontrastivePoint,
) -> Int32 {
  self.label
}

///|
pub fn NlpembedcontrastivePoint::dist(
  self : NlpembedcontrastivePoint,
  other : NlpembedcontrastivePoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn NlpembedcontrastivePoint::add(
  self : NlpembedcontrastivePoint,
  other : NlpembedcontrastivePoint,
) -> NlpembedcontrastivePoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn NlpembedcontrastivePoint::sub(
  self : NlpembedcontrastivePoint,
  other : NlpembedcontrastivePoint,
) -> NlpembedcontrastivePoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn NlpembedcontrastivePoint::scale(
  self : NlpembedcontrastivePoint,
  s : Double,
) -> NlpembedcontrastivePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn NlpembedcontrastivePoint::dot(
  self : NlpembedcontrastivePoint,
  other : NlpembedcontrastivePoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn NlpembedcontrastivePoint::cross(
  self : NlpembedcontrastivePoint,
  other : NlpembedcontrastivePoint,
) -> NlpembedcontrastivePoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn NlpembedcontrastivePoint::norm(
  self : NlpembedcontrastivePoint,
) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn NlpembedcontrastivePoint::normalize(
  self : NlpembedcontrastivePoint,
) -> NlpembedcontrastivePoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn NlpembedcontrastivePoint::negate(
  self : NlpembedcontrastivePoint,
) -> NlpembedcontrastivePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn NlpembedcontrastivePoint::mid(
  self : NlpembedcontrastivePoint,
  other : NlpembedcontrastivePoint,
) -> NlpembedcontrastivePoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn NlpembedcontrastivePoint::lerp(
  self : NlpembedcontrastivePoint,
  other : NlpembedcontrastivePoint,
  t : Double,
) -> NlpembedcontrastivePoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn NlpembedcontrastivePoint::to_string(
  self : NlpembedcontrastivePoint,
) -> String {
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
pub(all) struct NlpembedcontrastiveSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn nlp_embed_contrastive_make_series(
  vals : Array[Double],
  name : String,
) -> NlpembedcontrastiveSeries {
  { vals, name, meta: 0, }
}

///|
pub fn NlpembedcontrastiveSeries::len(
  self : NlpembedcontrastiveSeries,
) -> Int32 {
  self.vals.length()
}

///|
pub fn NlpembedcontrastiveSeries::sum(
  self : NlpembedcontrastiveSeries,
) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn NlpembedcontrastiveSeries::mean(
  self : NlpembedcontrastiveSeries,
) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn NlpembedcontrastiveSeries::min(
  self : NlpembedcontrastiveSeries,
) -> Double {
  @_common.min(self.vals)
}

///|
pub fn NlpembedcontrastiveSeries::max(
  self : NlpembedcontrastiveSeries,
) -> Double {
  @_common.max(self.vals)
}

///|
pub fn NlpembedcontrastiveSeries::range(
  self : NlpembedcontrastiveSeries,
) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn NlpembedcontrastiveSeries::variance(
  self : NlpembedcontrastiveSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn NlpembedcontrastiveSeries::std(
  self : NlpembedcontrastiveSeries,
) -> Double {
  @_common.std(self.vals)
}

///|
pub fn NlpembedcontrastiveSeries::median(
  self : NlpembedcontrastiveSeries,
) -> Double {
  @_common.median(self.vals)
}

///|
pub fn NlpembedcontrastiveSeries::scale(
  self : NlpembedcontrastiveSeries,
  f : Double,
) -> NlpembedcontrastiveSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn NlpembedcontrastiveSeries::add(
  self : NlpembedcontrastiveSeries,
  other : NlpembedcontrastiveSeries,
) -> NlpembedcontrastiveSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn NlpembedcontrastiveSeries::sub(
  self : NlpembedcontrastiveSeries,
  other : NlpembedcontrastiveSeries,
) -> NlpembedcontrastiveSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn NlpembedcontrastiveSeries::normalize(
  self : NlpembedcontrastiveSeries,
) -> NlpembedcontrastiveSeries {
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
pub fn NlpembedcontrastiveSeries::cumsum(
  self : NlpembedcontrastiveSeries,
) -> NlpembedcontrastiveSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn NlpembedcontrastiveSeries::to_string(
  self : NlpembedcontrastiveSeries,
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
pub(all) struct NlpembedcontrastiveMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn nlp_embed_contrastive_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> NlpembedcontrastiveMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn nlp_embed_contrastive_matrix_identity(
  n : Int32,
) -> NlpembedcontrastiveMatrix {
  let m = nlp_embed_contrastive_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn NlpembedcontrastiveMatrix::get(
  self : NlpembedcontrastiveMatrix,
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
pub fn NlpembedcontrastiveMatrix::transpose(
  self : NlpembedcontrastiveMatrix,
) -> NlpembedcontrastiveMatrix {
  let result = nlp_embed_contrastive_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn NlpembedcontrastiveMatrix::add(
  self : NlpembedcontrastiveMatrix,
  other : NlpembedcontrastiveMatrix,
) -> NlpembedcontrastiveMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = nlp_embed_contrastive_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn NlpembedcontrastiveMatrix::scale(
  self : NlpembedcontrastiveMatrix,
  s : Double,
) -> NlpembedcontrastiveMatrix {
  let result = nlp_embed_contrastive_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn NlpembedcontrastiveMatrix::multiply(
  self : NlpembedcontrastiveMatrix,
  other : NlpembedcontrastiveMatrix,
) -> NlpembedcontrastiveMatrix {
  if self.cols != other.rows {
    return nlp_embed_contrastive_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = nlp_embed_contrastive_make_matrix(self.rows, other.cols, 0.0)
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
pub fn NlpembedcontrastiveMatrix::trace(
  self : NlpembedcontrastiveMatrix,
) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn NlpembedcontrastiveMatrix::det(
  self : NlpembedcontrastiveMatrix,
) -> Double {
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
pub fn NlpembedcontrastiveMatrix::norm(
  self : NlpembedcontrastiveMatrix,
) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn NlpembedcontrastiveMatrix::to_string(
  self : NlpembedcontrastiveMatrix,
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
pub(all) struct NlpembedcontrastiveVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn nlp_embed_contrastive_make_vector(
  comps : Array[Double],
) -> NlpembedcontrastiveVector {
  { comps, dim: comps.length(), }
}

///|
pub fn nlp_embed_contrastive_vector_zero(
  dim : Int32,
) -> NlpembedcontrastiveVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn NlpembedcontrastiveVector::add(
  self : NlpembedcontrastiveVector,
  other : NlpembedcontrastiveVector,
) -> NlpembedcontrastiveVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn NlpembedcontrastiveVector::sub(
  self : NlpembedcontrastiveVector,
  other : NlpembedcontrastiveVector,
) -> NlpembedcontrastiveVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn NlpembedcontrastiveVector::scale(
  self : NlpembedcontrastiveVector,
  s : Double,
) -> NlpembedcontrastiveVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn NlpembedcontrastiveVector::dot(
  self : NlpembedcontrastiveVector,
  other : NlpembedcontrastiveVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn NlpembedcontrastiveVector::norm(
  self : NlpembedcontrastiveVector,
) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn NlpembedcontrastiveVector::normalize(
  self : NlpembedcontrastiveVector,
) -> NlpembedcontrastiveVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn NlpembedcontrastiveVector::dist(
  self : NlpembedcontrastiveVector,
  other : NlpembedcontrastiveVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn NlpembedcontrastiveVector::to_string(
  self : NlpembedcontrastiveVector,
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
pub(all) struct NlpembedcontrastiveFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_embed_contrastive_frame_make(
  size : Int32,
) -> NlpembedcontrastiveFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NlpembedcontrastiveFrame::len(self : NlpembedcontrastiveFrame) -> Int32 {
  self.size
}

///|
pub fn NlpembedcontrastiveFrame::get(
  self : NlpembedcontrastiveFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NlpembedcontrastiveFrame::set(
  self : NlpembedcontrastiveFrame,
  i : Int32,
  v : Double,
) -> NlpembedcontrastiveFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NlpembedcontrastiveFrame::sum(self : NlpembedcontrastiveFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NlpembedcontrastiveFrame::mean(
  self : NlpembedcontrastiveFrame,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NlpembedcontrastiveFrame::scale(
  self : NlpembedcontrastiveFrame,
  f : Double,
) -> NlpembedcontrastiveFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NlpembedcontrastiveFrame::add(
  self : NlpembedcontrastiveFrame,
  other : NlpembedcontrastiveFrame,
) -> NlpembedcontrastiveFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NlpembedcontrastiveFrame::copy(
  self : NlpembedcontrastiveFrame,
) -> NlpembedcontrastiveFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NlpembedcontrastiveFrame::fill(
  self : NlpembedcontrastiveFrame,
  v : Double,
) -> NlpembedcontrastiveFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NlpembedcontrastiveFrame::min(self : NlpembedcontrastiveFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn NlpembedcontrastiveFrame::max(self : NlpembedcontrastiveFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn NlpembedcontrastiveFrame::to_string(
  self : NlpembedcontrastiveFrame,
) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NlpembedcontrastiveTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_embed_contrastive_table_make(
  size : Int32,
) -> NlpembedcontrastiveTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NlpembedcontrastiveTable::len(self : NlpembedcontrastiveTable) -> Int32 {
  self.size
}

///|
pub fn NlpembedcontrastiveTable::get(
  self : NlpembedcontrastiveTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NlpembedcontrastiveTable::set(
  self : NlpembedcontrastiveTable,
  i : Int32,
  v : Double,
) -> NlpembedcontrastiveTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NlpembedcontrastiveTable::sum(self : NlpembedcontrastiveTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NlpembedcontrastiveTable::mean(
  self : NlpembedcontrastiveTable,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NlpembedcontrastiveTable::scale(
  self : NlpembedcontrastiveTable,
  f : Double,
) -> NlpembedcontrastiveTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NlpembedcontrastiveTable::add(
  self : NlpembedcontrastiveTable,
  other : NlpembedcontrastiveTable,
) -> NlpembedcontrastiveTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NlpembedcontrastiveTable::copy(
  self : NlpembedcontrastiveTable,
) -> NlpembedcontrastiveTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NlpembedcontrastiveTable::fill(
  self : NlpembedcontrastiveTable,
  v : Double,
) -> NlpembedcontrastiveTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NlpembedcontrastiveTable::min(self : NlpembedcontrastiveTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn NlpembedcontrastiveTable::max(self : NlpembedcontrastiveTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn NlpembedcontrastiveTable::to_string(
  self : NlpembedcontrastiveTable,
) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NlpembedcontrastiveGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_embed_contrastive_graphn_make(
  size : Int32,
) -> NlpembedcontrastiveGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NlpembedcontrastiveGraphN::len(
  self : NlpembedcontrastiveGraphN,
) -> Int32 {
  self.size
}

///|
pub fn NlpembedcontrastiveGraphN::get(
  self : NlpembedcontrastiveGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NlpembedcontrastiveGraphN::set(
  self : NlpembedcontrastiveGraphN,
  i : Int32,
  v : Double,
) -> NlpembedcontrastiveGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NlpembedcontrastiveGraphN::sum(
  self : NlpembedcontrastiveGraphN,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NlpembedcontrastiveGraphN::mean(
  self : NlpembedcontrastiveGraphN,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NlpembedcontrastiveGraphN::scale(
  self : NlpembedcontrastiveGraphN,
  f : Double,
) -> NlpembedcontrastiveGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NlpembedcontrastiveGraphN::add(
  self : NlpembedcontrastiveGraphN,
  other : NlpembedcontrastiveGraphN,
) -> NlpembedcontrastiveGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NlpembedcontrastiveGraphN::copy(
  self : NlpembedcontrastiveGraphN,
) -> NlpembedcontrastiveGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NlpembedcontrastiveGraphN::fill(
  self : NlpembedcontrastiveGraphN,
  v : Double,
) -> NlpembedcontrastiveGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NlpembedcontrastiveGraphN::min(
  self : NlpembedcontrastiveGraphN,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn NlpembedcontrastiveGraphN::max(
  self : NlpembedcontrastiveGraphN,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn NlpembedcontrastiveGraphN::to_string(
  self : NlpembedcontrastiveGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NlpembedcontrastiveNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_embed_contrastive_node_make(size : Int32) -> NlpembedcontrastiveNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NlpembedcontrastiveNode::len(self : NlpembedcontrastiveNode) -> Int32 {
  self.size
}

///|
pub fn NlpembedcontrastiveNode::get(
  self : NlpembedcontrastiveNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NlpembedcontrastiveNode::set(
  self : NlpembedcontrastiveNode,
  i : Int32,
  v : Double,
) -> NlpembedcontrastiveNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NlpembedcontrastiveNode::sum(self : NlpembedcontrastiveNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NlpembedcontrastiveNode::mean(self : NlpembedcontrastiveNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NlpembedcontrastiveNode::scale(
  self : NlpembedcontrastiveNode,
  f : Double,
) -> NlpembedcontrastiveNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NlpembedcontrastiveNode::add(
  self : NlpembedcontrastiveNode,
  other : NlpembedcontrastiveNode,
) -> NlpembedcontrastiveNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NlpembedcontrastiveNode::copy(
  self : NlpembedcontrastiveNode,
) -> NlpembedcontrastiveNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NlpembedcontrastiveNode::fill(
  self : NlpembedcontrastiveNode,
  v : Double,
) -> NlpembedcontrastiveNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NlpembedcontrastiveNode::min(self : NlpembedcontrastiveNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn NlpembedcontrastiveNode::max(self : NlpembedcontrastiveNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn NlpembedcontrastiveNode::to_string(
  self : NlpembedcontrastiveNode,
) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NlpembedcontrastiveEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_embed_contrastive_edge_make(size : Int32) -> NlpembedcontrastiveEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NlpembedcontrastiveEdge::len(self : NlpembedcontrastiveEdge) -> Int32 {
  self.size
}

///|
pub fn NlpembedcontrastiveEdge::get(
  self : NlpembedcontrastiveEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NlpembedcontrastiveEdge::set(
  self : NlpembedcontrastiveEdge,
  i : Int32,
  v : Double,
) -> NlpembedcontrastiveEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NlpembedcontrastiveEdge::sum(self : NlpembedcontrastiveEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NlpembedcontrastiveEdge::mean(self : NlpembedcontrastiveEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NlpembedcontrastiveEdge::scale(
  self : NlpembedcontrastiveEdge,
  f : Double,
) -> NlpembedcontrastiveEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NlpembedcontrastiveEdge::add(
  self : NlpembedcontrastiveEdge,
  other : NlpembedcontrastiveEdge,
) -> NlpembedcontrastiveEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NlpembedcontrastiveEdge::copy(
  self : NlpembedcontrastiveEdge,
) -> NlpembedcontrastiveEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NlpembedcontrastiveEdge::fill(
  self : NlpembedcontrastiveEdge,
  v : Double,
) -> NlpembedcontrastiveEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NlpembedcontrastiveEdge::min(self : NlpembedcontrastiveEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn NlpembedcontrastiveEdge::max(self : NlpembedcontrastiveEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn NlpembedcontrastiveEdge::to_string(
  self : NlpembedcontrastiveEdge,
) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NlpembedcontrastivePath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_embed_contrastive_path_make(size : Int32) -> NlpembedcontrastivePath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NlpembedcontrastivePath::len(self : NlpembedcontrastivePath) -> Int32 {
  self.size
}

///|
pub fn NlpembedcontrastivePath::get(
  self : NlpembedcontrastivePath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NlpembedcontrastivePath::set(
  self : NlpembedcontrastivePath,
  i : Int32,
  v : Double,
) -> NlpembedcontrastivePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NlpembedcontrastivePath::sum(self : NlpembedcontrastivePath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NlpembedcontrastivePath::mean(self : NlpembedcontrastivePath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NlpembedcontrastivePath::scale(
  self : NlpembedcontrastivePath,
  f : Double,
) -> NlpembedcontrastivePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NlpembedcontrastivePath::add(
  self : NlpembedcontrastivePath,
  other : NlpembedcontrastivePath,
) -> NlpembedcontrastivePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NlpembedcontrastivePath::copy(
  self : NlpembedcontrastivePath,
) -> NlpembedcontrastivePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NlpembedcontrastivePath::fill(
  self : NlpembedcontrastivePath,
  v : Double,
) -> NlpembedcontrastivePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NlpembedcontrastivePath::min(self : NlpembedcontrastivePath) -> Double {
  @_common.min(self.data)
}

///|
pub fn NlpembedcontrastivePath::max(self : NlpembedcontrastivePath) -> Double {
  @_common.max(self.data)
}

///|
pub fn NlpembedcontrastivePath::to_string(
  self : NlpembedcontrastivePath,
) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NlpembedcontrastiveCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_embed_contrastive_cluster_make(
  size : Int32,
) -> NlpembedcontrastiveCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NlpembedcontrastiveCluster::len(
  self : NlpembedcontrastiveCluster,
) -> Int32 {
  self.size
}

///|
pub fn NlpembedcontrastiveCluster::get(
  self : NlpembedcontrastiveCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NlpembedcontrastiveCluster::set(
  self : NlpembedcontrastiveCluster,
  i : Int32,
  v : Double,
) -> NlpembedcontrastiveCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NlpembedcontrastiveCluster::sum(
  self : NlpembedcontrastiveCluster,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NlpembedcontrastiveCluster::mean(
  self : NlpembedcontrastiveCluster,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NlpembedcontrastiveCluster::scale(
  self : NlpembedcontrastiveCluster,
  f : Double,
) -> NlpembedcontrastiveCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NlpembedcontrastiveCluster::add(
  self : NlpembedcontrastiveCluster,
  other : NlpembedcontrastiveCluster,
) -> NlpembedcontrastiveCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NlpembedcontrastiveCluster::copy(
  self : NlpembedcontrastiveCluster,
) -> NlpembedcontrastiveCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NlpembedcontrastiveCluster::fill(
  self : NlpembedcontrastiveCluster,
  v : Double,
) -> NlpembedcontrastiveCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NlpembedcontrastiveCluster::min(
  self : NlpembedcontrastiveCluster,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn NlpembedcontrastiveCluster::max(
  self : NlpembedcontrastiveCluster,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn NlpembedcontrastiveCluster::to_string(
  self : NlpembedcontrastiveCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NlpembedcontrastiveModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_embed_contrastive_model_make(
  size : Int32,
) -> NlpembedcontrastiveModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NlpembedcontrastiveModel::len(self : NlpembedcontrastiveModel) -> Int32 {
  self.size
}

///|
pub fn NlpembedcontrastiveModel::get(
  self : NlpembedcontrastiveModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NlpembedcontrastiveModel::set(
  self : NlpembedcontrastiveModel,
  i : Int32,
  v : Double,
) -> NlpembedcontrastiveModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NlpembedcontrastiveModel::sum(self : NlpembedcontrastiveModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NlpembedcontrastiveModel::mean(
  self : NlpembedcontrastiveModel,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NlpembedcontrastiveModel::scale(
  self : NlpembedcontrastiveModel,
  f : Double,
) -> NlpembedcontrastiveModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NlpembedcontrastiveModel::add(
  self : NlpembedcontrastiveModel,
  other : NlpembedcontrastiveModel,
) -> NlpembedcontrastiveModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NlpembedcontrastiveModel::copy(
  self : NlpembedcontrastiveModel,
) -> NlpembedcontrastiveModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NlpembedcontrastiveModel::fill(
  self : NlpembedcontrastiveModel,
  v : Double,
) -> NlpembedcontrastiveModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NlpembedcontrastiveModel::min(self : NlpembedcontrastiveModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn NlpembedcontrastiveModel::max(self : NlpembedcontrastiveModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn NlpembedcontrastiveModel::to_string(
  self : NlpembedcontrastiveModel,
) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NlpembedcontrastiveLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_embed_contrastive_layer_make(
  size : Int32,
) -> NlpembedcontrastiveLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NlpembedcontrastiveLayer::len(self : NlpembedcontrastiveLayer) -> Int32 {
  self.size
}

///|
pub fn NlpembedcontrastiveLayer::get(
  self : NlpembedcontrastiveLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NlpembedcontrastiveLayer::set(
  self : NlpembedcontrastiveLayer,
  i : Int32,
  v : Double,
) -> NlpembedcontrastiveLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NlpembedcontrastiveLayer::sum(self : NlpembedcontrastiveLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NlpembedcontrastiveLayer::mean(
  self : NlpembedcontrastiveLayer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NlpembedcontrastiveLayer::scale(
  self : NlpembedcontrastiveLayer,
  f : Double,
) -> NlpembedcontrastiveLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NlpembedcontrastiveLayer::add(
  self : NlpembedcontrastiveLayer,
  other : NlpembedcontrastiveLayer,
) -> NlpembedcontrastiveLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NlpembedcontrastiveLayer::copy(
  self : NlpembedcontrastiveLayer,
) -> NlpembedcontrastiveLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NlpembedcontrastiveLayer::fill(
  self : NlpembedcontrastiveLayer,
  v : Double,
) -> NlpembedcontrastiveLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NlpembedcontrastiveLayer::min(self : NlpembedcontrastiveLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn NlpembedcontrastiveLayer::max(self : NlpembedcontrastiveLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn NlpembedcontrastiveLayer::to_string(
  self : NlpembedcontrastiveLayer,
) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NlpembedcontrastiveBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_embed_contrastive_buffer_make(
  size : Int32,
) -> NlpembedcontrastiveBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NlpembedcontrastiveBuffer::len(
  self : NlpembedcontrastiveBuffer,
) -> Int32 {
  self.size
}

///|
pub fn NlpembedcontrastiveBuffer::get(
  self : NlpembedcontrastiveBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NlpembedcontrastiveBuffer::set(
  self : NlpembedcontrastiveBuffer,
  i : Int32,
  v : Double,
) -> NlpembedcontrastiveBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NlpembedcontrastiveBuffer::sum(
  self : NlpembedcontrastiveBuffer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NlpembedcontrastiveBuffer::mean(
  self : NlpembedcontrastiveBuffer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NlpembedcontrastiveBuffer::scale(
  self : NlpembedcontrastiveBuffer,
  f : Double,
) -> NlpembedcontrastiveBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NlpembedcontrastiveBuffer::add(
  self : NlpembedcontrastiveBuffer,
  other : NlpembedcontrastiveBuffer,
) -> NlpembedcontrastiveBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NlpembedcontrastiveBuffer::copy(
  self : NlpembedcontrastiveBuffer,
) -> NlpembedcontrastiveBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NlpembedcontrastiveBuffer::fill(
  self : NlpembedcontrastiveBuffer,
  v : Double,
) -> NlpembedcontrastiveBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NlpembedcontrastiveBuffer::min(
  self : NlpembedcontrastiveBuffer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn NlpembedcontrastiveBuffer::max(
  self : NlpembedcontrastiveBuffer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn NlpembedcontrastiveBuffer::to_string(
  self : NlpembedcontrastiveBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NlpembedcontrastiveCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_embed_contrastive_cursor_make(
  size : Int32,
) -> NlpembedcontrastiveCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NlpembedcontrastiveCursor::len(
  self : NlpembedcontrastiveCursor,
) -> Int32 {
  self.size
}

///|
pub fn NlpembedcontrastiveCursor::get(
  self : NlpembedcontrastiveCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NlpembedcontrastiveCursor::set(
  self : NlpembedcontrastiveCursor,
  i : Int32,
  v : Double,
) -> NlpembedcontrastiveCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NlpembedcontrastiveCursor::sum(
  self : NlpembedcontrastiveCursor,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NlpembedcontrastiveCursor::mean(
  self : NlpembedcontrastiveCursor,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NlpembedcontrastiveCursor::scale(
  self : NlpembedcontrastiveCursor,
  f : Double,
) -> NlpembedcontrastiveCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NlpembedcontrastiveCursor::add(
  self : NlpembedcontrastiveCursor,
  other : NlpembedcontrastiveCursor,
) -> NlpembedcontrastiveCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NlpembedcontrastiveCursor::copy(
  self : NlpembedcontrastiveCursor,
) -> NlpembedcontrastiveCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NlpembedcontrastiveCursor::fill(
  self : NlpembedcontrastiveCursor,
  v : Double,
) -> NlpembedcontrastiveCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NlpembedcontrastiveCursor::min(
  self : NlpembedcontrastiveCursor,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn NlpembedcontrastiveCursor::max(
  self : NlpembedcontrastiveCursor,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn NlpembedcontrastiveCursor::to_string(
  self : NlpembedcontrastiveCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NlpembedcontrastiveView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_embed_contrastive_view_make(size : Int32) -> NlpembedcontrastiveView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NlpembedcontrastiveView::len(self : NlpembedcontrastiveView) -> Int32 {
  self.size
}

///|
pub fn NlpembedcontrastiveView::get(
  self : NlpembedcontrastiveView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NlpembedcontrastiveView::set(
  self : NlpembedcontrastiveView,
  i : Int32,
  v : Double,
) -> NlpembedcontrastiveView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NlpembedcontrastiveView::sum(self : NlpembedcontrastiveView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NlpembedcontrastiveView::mean(self : NlpembedcontrastiveView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NlpembedcontrastiveView::scale(
  self : NlpembedcontrastiveView,
  f : Double,
) -> NlpembedcontrastiveView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NlpembedcontrastiveView::add(
  self : NlpembedcontrastiveView,
  other : NlpembedcontrastiveView,
) -> NlpembedcontrastiveView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NlpembedcontrastiveView::copy(
  self : NlpembedcontrastiveView,
) -> NlpembedcontrastiveView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NlpembedcontrastiveView::fill(
  self : NlpembedcontrastiveView,
  v : Double,
) -> NlpembedcontrastiveView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NlpembedcontrastiveView::min(self : NlpembedcontrastiveView) -> Double {
  @_common.min(self.data)
}

///|
pub fn NlpembedcontrastiveView::max(self : NlpembedcontrastiveView) -> Double {
  @_common.max(self.data)
}

///|
pub fn NlpembedcontrastiveView::to_string(
  self : NlpembedcontrastiveView,
) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NlpembedcontrastiveRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_embed_contrastive_range_make(
  size : Int32,
) -> NlpembedcontrastiveRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NlpembedcontrastiveRange::len(self : NlpembedcontrastiveRange) -> Int32 {
  self.size
}

///|
pub fn NlpembedcontrastiveRange::get(
  self : NlpembedcontrastiveRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NlpembedcontrastiveRange::set(
  self : NlpembedcontrastiveRange,
  i : Int32,
  v : Double,
) -> NlpembedcontrastiveRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NlpembedcontrastiveRange::sum(self : NlpembedcontrastiveRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NlpembedcontrastiveRange::mean(
  self : NlpembedcontrastiveRange,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NlpembedcontrastiveRange::scale(
  self : NlpembedcontrastiveRange,
  f : Double,
) -> NlpembedcontrastiveRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NlpembedcontrastiveRange::add(
  self : NlpembedcontrastiveRange,
  other : NlpembedcontrastiveRange,
) -> NlpembedcontrastiveRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NlpembedcontrastiveRange::copy(
  self : NlpembedcontrastiveRange,
) -> NlpembedcontrastiveRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NlpembedcontrastiveRange::fill(
  self : NlpembedcontrastiveRange,
  v : Double,
) -> NlpembedcontrastiveRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NlpembedcontrastiveRange::min(self : NlpembedcontrastiveRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn NlpembedcontrastiveRange::max(self : NlpembedcontrastiveRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn NlpembedcontrastiveRange::to_string(
  self : NlpembedcontrastiveRange,
) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NlpembedcontrastiveSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_embed_contrastive_slice_make(
  size : Int32,
) -> NlpembedcontrastiveSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NlpembedcontrastiveSlice::len(self : NlpembedcontrastiveSlice) -> Int32 {
  self.size
}

///|
pub fn NlpembedcontrastiveSlice::get(
  self : NlpembedcontrastiveSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NlpembedcontrastiveSlice::set(
  self : NlpembedcontrastiveSlice,
  i : Int32,
  v : Double,
) -> NlpembedcontrastiveSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NlpembedcontrastiveSlice::sum(self : NlpembedcontrastiveSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NlpembedcontrastiveSlice::mean(
  self : NlpembedcontrastiveSlice,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NlpembedcontrastiveSlice::scale(
  self : NlpembedcontrastiveSlice,
  f : Double,
) -> NlpembedcontrastiveSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NlpembedcontrastiveSlice::add(
  self : NlpembedcontrastiveSlice,
  other : NlpembedcontrastiveSlice,
) -> NlpembedcontrastiveSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NlpembedcontrastiveSlice::copy(
  self : NlpembedcontrastiveSlice,
) -> NlpembedcontrastiveSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NlpembedcontrastiveSlice::fill(
  self : NlpembedcontrastiveSlice,
  v : Double,
) -> NlpembedcontrastiveSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NlpembedcontrastiveSlice::min(self : NlpembedcontrastiveSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn NlpembedcontrastiveSlice::max(self : NlpembedcontrastiveSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn NlpembedcontrastiveSlice::to_string(
  self : NlpembedcontrastiveSlice,
) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
