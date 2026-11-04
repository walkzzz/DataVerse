///|
///===
/// extcore/ml_classify_logistic
pub(all) struct MlclassifylogisticPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn ml_classify_logistic_make_point(
  x : Double,
  y : Double,
) -> MlclassifylogisticPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn ml_classify_logistic_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> MlclassifylogisticPoint {
  { x, y, z, label: 0, }
}

///|
pub fn MlclassifylogisticPoint::x(self : MlclassifylogisticPoint) -> Double {
  self.x
}

///|
pub fn MlclassifylogisticPoint::y(self : MlclassifylogisticPoint) -> Double {
  self.y
}

///|
pub fn MlclassifylogisticPoint::z(self : MlclassifylogisticPoint) -> Double {
  self.z
}

///|
pub fn MlclassifylogisticPoint::label(self : MlclassifylogisticPoint) -> Int32 {
  self.label
}

///|
pub fn MlclassifylogisticPoint::dist(
  self : MlclassifylogisticPoint,
  other : MlclassifylogisticPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn MlclassifylogisticPoint::add(
  self : MlclassifylogisticPoint,
  other : MlclassifylogisticPoint,
) -> MlclassifylogisticPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn MlclassifylogisticPoint::sub(
  self : MlclassifylogisticPoint,
  other : MlclassifylogisticPoint,
) -> MlclassifylogisticPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn MlclassifylogisticPoint::scale(
  self : MlclassifylogisticPoint,
  s : Double,
) -> MlclassifylogisticPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn MlclassifylogisticPoint::dot(
  self : MlclassifylogisticPoint,
  other : MlclassifylogisticPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn MlclassifylogisticPoint::cross(
  self : MlclassifylogisticPoint,
  other : MlclassifylogisticPoint,
) -> MlclassifylogisticPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn MlclassifylogisticPoint::norm(self : MlclassifylogisticPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn MlclassifylogisticPoint::normalize(
  self : MlclassifylogisticPoint,
) -> MlclassifylogisticPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn MlclassifylogisticPoint::negate(
  self : MlclassifylogisticPoint,
) -> MlclassifylogisticPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn MlclassifylogisticPoint::mid(
  self : MlclassifylogisticPoint,
  other : MlclassifylogisticPoint,
) -> MlclassifylogisticPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn MlclassifylogisticPoint::lerp(
  self : MlclassifylogisticPoint,
  other : MlclassifylogisticPoint,
  t : Double,
) -> MlclassifylogisticPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn MlclassifylogisticPoint::to_string(
  self : MlclassifylogisticPoint,
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
pub(all) struct MlclassifylogisticSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn ml_classify_logistic_make_series(
  vals : Array[Double],
  name : String,
) -> MlclassifylogisticSeries {
  { vals, name, meta: 0, }
}

///|
pub fn MlclassifylogisticSeries::len(self : MlclassifylogisticSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn MlclassifylogisticSeries::sum(self : MlclassifylogisticSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn MlclassifylogisticSeries::mean(
  self : MlclassifylogisticSeries,
) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn MlclassifylogisticSeries::min(self : MlclassifylogisticSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn MlclassifylogisticSeries::max(self : MlclassifylogisticSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn MlclassifylogisticSeries::range(
  self : MlclassifylogisticSeries,
) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn MlclassifylogisticSeries::variance(
  self : MlclassifylogisticSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn MlclassifylogisticSeries::std(self : MlclassifylogisticSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn MlclassifylogisticSeries::median(
  self : MlclassifylogisticSeries,
) -> Double {
  @_common.median(self.vals)
}

///|
pub fn MlclassifylogisticSeries::scale(
  self : MlclassifylogisticSeries,
  f : Double,
) -> MlclassifylogisticSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn MlclassifylogisticSeries::add(
  self : MlclassifylogisticSeries,
  other : MlclassifylogisticSeries,
) -> MlclassifylogisticSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn MlclassifylogisticSeries::sub(
  self : MlclassifylogisticSeries,
  other : MlclassifylogisticSeries,
) -> MlclassifylogisticSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn MlclassifylogisticSeries::normalize(
  self : MlclassifylogisticSeries,
) -> MlclassifylogisticSeries {
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
pub fn MlclassifylogisticSeries::cumsum(
  self : MlclassifylogisticSeries,
) -> MlclassifylogisticSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn MlclassifylogisticSeries::to_string(
  self : MlclassifylogisticSeries,
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
pub(all) struct MlclassifylogisticMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn ml_classify_logistic_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> MlclassifylogisticMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn ml_classify_logistic_matrix_identity(
  n : Int32,
) -> MlclassifylogisticMatrix {
  let m = ml_classify_logistic_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn MlclassifylogisticMatrix::get(
  self : MlclassifylogisticMatrix,
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
pub fn MlclassifylogisticMatrix::transpose(
  self : MlclassifylogisticMatrix,
) -> MlclassifylogisticMatrix {
  let result = ml_classify_logistic_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn MlclassifylogisticMatrix::add(
  self : MlclassifylogisticMatrix,
  other : MlclassifylogisticMatrix,
) -> MlclassifylogisticMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = ml_classify_logistic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn MlclassifylogisticMatrix::scale(
  self : MlclassifylogisticMatrix,
  s : Double,
) -> MlclassifylogisticMatrix {
  let result = ml_classify_logistic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn MlclassifylogisticMatrix::multiply(
  self : MlclassifylogisticMatrix,
  other : MlclassifylogisticMatrix,
) -> MlclassifylogisticMatrix {
  if self.cols != other.rows {
    return ml_classify_logistic_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = ml_classify_logistic_make_matrix(self.rows, other.cols, 0.0)
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
pub fn MlclassifylogisticMatrix::trace(
  self : MlclassifylogisticMatrix,
) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn MlclassifylogisticMatrix::det(self : MlclassifylogisticMatrix) -> Double {
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
pub fn MlclassifylogisticMatrix::norm(
  self : MlclassifylogisticMatrix,
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
pub fn MlclassifylogisticMatrix::to_string(
  self : MlclassifylogisticMatrix,
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
pub(all) struct MlclassifylogisticVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn ml_classify_logistic_make_vector(
  comps : Array[Double],
) -> MlclassifylogisticVector {
  { comps, dim: comps.length(), }
}

///|
pub fn ml_classify_logistic_vector_zero(
  dim : Int32,
) -> MlclassifylogisticVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn MlclassifylogisticVector::add(
  self : MlclassifylogisticVector,
  other : MlclassifylogisticVector,
) -> MlclassifylogisticVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn MlclassifylogisticVector::sub(
  self : MlclassifylogisticVector,
  other : MlclassifylogisticVector,
) -> MlclassifylogisticVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn MlclassifylogisticVector::scale(
  self : MlclassifylogisticVector,
  s : Double,
) -> MlclassifylogisticVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn MlclassifylogisticVector::dot(
  self : MlclassifylogisticVector,
  other : MlclassifylogisticVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn MlclassifylogisticVector::norm(
  self : MlclassifylogisticVector,
) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn MlclassifylogisticVector::normalize(
  self : MlclassifylogisticVector,
) -> MlclassifylogisticVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn MlclassifylogisticVector::dist(
  self : MlclassifylogisticVector,
  other : MlclassifylogisticVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn MlclassifylogisticVector::to_string(
  self : MlclassifylogisticVector,
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
pub(all) struct MlclassifylogisticFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_classify_logistic_frame_make(size : Int32) -> MlclassifylogisticFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlclassifylogisticFrame::len(self : MlclassifylogisticFrame) -> Int32 {
  self.size
}

///|
pub fn MlclassifylogisticFrame::get(
  self : MlclassifylogisticFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlclassifylogisticFrame::set(
  self : MlclassifylogisticFrame,
  i : Int32,
  v : Double,
) -> MlclassifylogisticFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlclassifylogisticFrame::sum(self : MlclassifylogisticFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlclassifylogisticFrame::mean(self : MlclassifylogisticFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlclassifylogisticFrame::scale(
  self : MlclassifylogisticFrame,
  f : Double,
) -> MlclassifylogisticFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlclassifylogisticFrame::add(
  self : MlclassifylogisticFrame,
  other : MlclassifylogisticFrame,
) -> MlclassifylogisticFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlclassifylogisticFrame::copy(
  self : MlclassifylogisticFrame,
) -> MlclassifylogisticFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlclassifylogisticFrame::fill(
  self : MlclassifylogisticFrame,
  v : Double,
) -> MlclassifylogisticFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlclassifylogisticFrame::min(self : MlclassifylogisticFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlclassifylogisticFrame::max(self : MlclassifylogisticFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlclassifylogisticFrame::to_string(
  self : MlclassifylogisticFrame,
) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlclassifylogisticTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_classify_logistic_table_make(size : Int32) -> MlclassifylogisticTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlclassifylogisticTable::len(self : MlclassifylogisticTable) -> Int32 {
  self.size
}

///|
pub fn MlclassifylogisticTable::get(
  self : MlclassifylogisticTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlclassifylogisticTable::set(
  self : MlclassifylogisticTable,
  i : Int32,
  v : Double,
) -> MlclassifylogisticTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlclassifylogisticTable::sum(self : MlclassifylogisticTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlclassifylogisticTable::mean(self : MlclassifylogisticTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlclassifylogisticTable::scale(
  self : MlclassifylogisticTable,
  f : Double,
) -> MlclassifylogisticTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlclassifylogisticTable::add(
  self : MlclassifylogisticTable,
  other : MlclassifylogisticTable,
) -> MlclassifylogisticTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlclassifylogisticTable::copy(
  self : MlclassifylogisticTable,
) -> MlclassifylogisticTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlclassifylogisticTable::fill(
  self : MlclassifylogisticTable,
  v : Double,
) -> MlclassifylogisticTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlclassifylogisticTable::min(self : MlclassifylogisticTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlclassifylogisticTable::max(self : MlclassifylogisticTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlclassifylogisticTable::to_string(
  self : MlclassifylogisticTable,
) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlclassifylogisticGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_classify_logistic_graphn_make(
  size : Int32,
) -> MlclassifylogisticGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlclassifylogisticGraphN::len(self : MlclassifylogisticGraphN) -> Int32 {
  self.size
}

///|
pub fn MlclassifylogisticGraphN::get(
  self : MlclassifylogisticGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlclassifylogisticGraphN::set(
  self : MlclassifylogisticGraphN,
  i : Int32,
  v : Double,
) -> MlclassifylogisticGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlclassifylogisticGraphN::sum(self : MlclassifylogisticGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlclassifylogisticGraphN::mean(
  self : MlclassifylogisticGraphN,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlclassifylogisticGraphN::scale(
  self : MlclassifylogisticGraphN,
  f : Double,
) -> MlclassifylogisticGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlclassifylogisticGraphN::add(
  self : MlclassifylogisticGraphN,
  other : MlclassifylogisticGraphN,
) -> MlclassifylogisticGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlclassifylogisticGraphN::copy(
  self : MlclassifylogisticGraphN,
) -> MlclassifylogisticGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlclassifylogisticGraphN::fill(
  self : MlclassifylogisticGraphN,
  v : Double,
) -> MlclassifylogisticGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlclassifylogisticGraphN::min(self : MlclassifylogisticGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlclassifylogisticGraphN::max(self : MlclassifylogisticGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlclassifylogisticGraphN::to_string(
  self : MlclassifylogisticGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlclassifylogisticNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_classify_logistic_node_make(size : Int32) -> MlclassifylogisticNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlclassifylogisticNode::len(self : MlclassifylogisticNode) -> Int32 {
  self.size
}

///|
pub fn MlclassifylogisticNode::get(
  self : MlclassifylogisticNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlclassifylogisticNode::set(
  self : MlclassifylogisticNode,
  i : Int32,
  v : Double,
) -> MlclassifylogisticNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlclassifylogisticNode::sum(self : MlclassifylogisticNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlclassifylogisticNode::mean(self : MlclassifylogisticNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlclassifylogisticNode::scale(
  self : MlclassifylogisticNode,
  f : Double,
) -> MlclassifylogisticNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlclassifylogisticNode::add(
  self : MlclassifylogisticNode,
  other : MlclassifylogisticNode,
) -> MlclassifylogisticNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlclassifylogisticNode::copy(
  self : MlclassifylogisticNode,
) -> MlclassifylogisticNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlclassifylogisticNode::fill(
  self : MlclassifylogisticNode,
  v : Double,
) -> MlclassifylogisticNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlclassifylogisticNode::min(self : MlclassifylogisticNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlclassifylogisticNode::max(self : MlclassifylogisticNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlclassifylogisticNode::to_string(
  self : MlclassifylogisticNode,
) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlclassifylogisticEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_classify_logistic_edge_make(size : Int32) -> MlclassifylogisticEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlclassifylogisticEdge::len(self : MlclassifylogisticEdge) -> Int32 {
  self.size
}

///|
pub fn MlclassifylogisticEdge::get(
  self : MlclassifylogisticEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlclassifylogisticEdge::set(
  self : MlclassifylogisticEdge,
  i : Int32,
  v : Double,
) -> MlclassifylogisticEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlclassifylogisticEdge::sum(self : MlclassifylogisticEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlclassifylogisticEdge::mean(self : MlclassifylogisticEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlclassifylogisticEdge::scale(
  self : MlclassifylogisticEdge,
  f : Double,
) -> MlclassifylogisticEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlclassifylogisticEdge::add(
  self : MlclassifylogisticEdge,
  other : MlclassifylogisticEdge,
) -> MlclassifylogisticEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlclassifylogisticEdge::copy(
  self : MlclassifylogisticEdge,
) -> MlclassifylogisticEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlclassifylogisticEdge::fill(
  self : MlclassifylogisticEdge,
  v : Double,
) -> MlclassifylogisticEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlclassifylogisticEdge::min(self : MlclassifylogisticEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlclassifylogisticEdge::max(self : MlclassifylogisticEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlclassifylogisticEdge::to_string(
  self : MlclassifylogisticEdge,
) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlclassifylogisticPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_classify_logistic_path_make(size : Int32) -> MlclassifylogisticPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlclassifylogisticPath::len(self : MlclassifylogisticPath) -> Int32 {
  self.size
}

///|
pub fn MlclassifylogisticPath::get(
  self : MlclassifylogisticPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlclassifylogisticPath::set(
  self : MlclassifylogisticPath,
  i : Int32,
  v : Double,
) -> MlclassifylogisticPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlclassifylogisticPath::sum(self : MlclassifylogisticPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlclassifylogisticPath::mean(self : MlclassifylogisticPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlclassifylogisticPath::scale(
  self : MlclassifylogisticPath,
  f : Double,
) -> MlclassifylogisticPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlclassifylogisticPath::add(
  self : MlclassifylogisticPath,
  other : MlclassifylogisticPath,
) -> MlclassifylogisticPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlclassifylogisticPath::copy(
  self : MlclassifylogisticPath,
) -> MlclassifylogisticPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlclassifylogisticPath::fill(
  self : MlclassifylogisticPath,
  v : Double,
) -> MlclassifylogisticPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlclassifylogisticPath::min(self : MlclassifylogisticPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlclassifylogisticPath::max(self : MlclassifylogisticPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlclassifylogisticPath::to_string(
  self : MlclassifylogisticPath,
) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlclassifylogisticCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_classify_logistic_cluster_make(
  size : Int32,
) -> MlclassifylogisticCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlclassifylogisticCluster::len(
  self : MlclassifylogisticCluster,
) -> Int32 {
  self.size
}

///|
pub fn MlclassifylogisticCluster::get(
  self : MlclassifylogisticCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlclassifylogisticCluster::set(
  self : MlclassifylogisticCluster,
  i : Int32,
  v : Double,
) -> MlclassifylogisticCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlclassifylogisticCluster::sum(
  self : MlclassifylogisticCluster,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlclassifylogisticCluster::mean(
  self : MlclassifylogisticCluster,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlclassifylogisticCluster::scale(
  self : MlclassifylogisticCluster,
  f : Double,
) -> MlclassifylogisticCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlclassifylogisticCluster::add(
  self : MlclassifylogisticCluster,
  other : MlclassifylogisticCluster,
) -> MlclassifylogisticCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlclassifylogisticCluster::copy(
  self : MlclassifylogisticCluster,
) -> MlclassifylogisticCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlclassifylogisticCluster::fill(
  self : MlclassifylogisticCluster,
  v : Double,
) -> MlclassifylogisticCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlclassifylogisticCluster::min(
  self : MlclassifylogisticCluster,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlclassifylogisticCluster::max(
  self : MlclassifylogisticCluster,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlclassifylogisticCluster::to_string(
  self : MlclassifylogisticCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlclassifylogisticModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_classify_logistic_model_make(size : Int32) -> MlclassifylogisticModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlclassifylogisticModel::len(self : MlclassifylogisticModel) -> Int32 {
  self.size
}

///|
pub fn MlclassifylogisticModel::get(
  self : MlclassifylogisticModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlclassifylogisticModel::set(
  self : MlclassifylogisticModel,
  i : Int32,
  v : Double,
) -> MlclassifylogisticModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlclassifylogisticModel::sum(self : MlclassifylogisticModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlclassifylogisticModel::mean(self : MlclassifylogisticModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlclassifylogisticModel::scale(
  self : MlclassifylogisticModel,
  f : Double,
) -> MlclassifylogisticModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlclassifylogisticModel::add(
  self : MlclassifylogisticModel,
  other : MlclassifylogisticModel,
) -> MlclassifylogisticModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlclassifylogisticModel::copy(
  self : MlclassifylogisticModel,
) -> MlclassifylogisticModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlclassifylogisticModel::fill(
  self : MlclassifylogisticModel,
  v : Double,
) -> MlclassifylogisticModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlclassifylogisticModel::min(self : MlclassifylogisticModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlclassifylogisticModel::max(self : MlclassifylogisticModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlclassifylogisticModel::to_string(
  self : MlclassifylogisticModel,
) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlclassifylogisticLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_classify_logistic_layer_make(size : Int32) -> MlclassifylogisticLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlclassifylogisticLayer::len(self : MlclassifylogisticLayer) -> Int32 {
  self.size
}

///|
pub fn MlclassifylogisticLayer::get(
  self : MlclassifylogisticLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlclassifylogisticLayer::set(
  self : MlclassifylogisticLayer,
  i : Int32,
  v : Double,
) -> MlclassifylogisticLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlclassifylogisticLayer::sum(self : MlclassifylogisticLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlclassifylogisticLayer::mean(self : MlclassifylogisticLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlclassifylogisticLayer::scale(
  self : MlclassifylogisticLayer,
  f : Double,
) -> MlclassifylogisticLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlclassifylogisticLayer::add(
  self : MlclassifylogisticLayer,
  other : MlclassifylogisticLayer,
) -> MlclassifylogisticLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlclassifylogisticLayer::copy(
  self : MlclassifylogisticLayer,
) -> MlclassifylogisticLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlclassifylogisticLayer::fill(
  self : MlclassifylogisticLayer,
  v : Double,
) -> MlclassifylogisticLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlclassifylogisticLayer::min(self : MlclassifylogisticLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlclassifylogisticLayer::max(self : MlclassifylogisticLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlclassifylogisticLayer::to_string(
  self : MlclassifylogisticLayer,
) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlclassifylogisticBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_classify_logistic_buffer_make(
  size : Int32,
) -> MlclassifylogisticBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlclassifylogisticBuffer::len(self : MlclassifylogisticBuffer) -> Int32 {
  self.size
}

///|
pub fn MlclassifylogisticBuffer::get(
  self : MlclassifylogisticBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlclassifylogisticBuffer::set(
  self : MlclassifylogisticBuffer,
  i : Int32,
  v : Double,
) -> MlclassifylogisticBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlclassifylogisticBuffer::sum(self : MlclassifylogisticBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlclassifylogisticBuffer::mean(
  self : MlclassifylogisticBuffer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlclassifylogisticBuffer::scale(
  self : MlclassifylogisticBuffer,
  f : Double,
) -> MlclassifylogisticBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlclassifylogisticBuffer::add(
  self : MlclassifylogisticBuffer,
  other : MlclassifylogisticBuffer,
) -> MlclassifylogisticBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlclassifylogisticBuffer::copy(
  self : MlclassifylogisticBuffer,
) -> MlclassifylogisticBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlclassifylogisticBuffer::fill(
  self : MlclassifylogisticBuffer,
  v : Double,
) -> MlclassifylogisticBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlclassifylogisticBuffer::min(self : MlclassifylogisticBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlclassifylogisticBuffer::max(self : MlclassifylogisticBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlclassifylogisticBuffer::to_string(
  self : MlclassifylogisticBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlclassifylogisticCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_classify_logistic_cursor_make(
  size : Int32,
) -> MlclassifylogisticCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlclassifylogisticCursor::len(self : MlclassifylogisticCursor) -> Int32 {
  self.size
}

///|
pub fn MlclassifylogisticCursor::get(
  self : MlclassifylogisticCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlclassifylogisticCursor::set(
  self : MlclassifylogisticCursor,
  i : Int32,
  v : Double,
) -> MlclassifylogisticCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlclassifylogisticCursor::sum(self : MlclassifylogisticCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlclassifylogisticCursor::mean(
  self : MlclassifylogisticCursor,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlclassifylogisticCursor::scale(
  self : MlclassifylogisticCursor,
  f : Double,
) -> MlclassifylogisticCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlclassifylogisticCursor::add(
  self : MlclassifylogisticCursor,
  other : MlclassifylogisticCursor,
) -> MlclassifylogisticCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlclassifylogisticCursor::copy(
  self : MlclassifylogisticCursor,
) -> MlclassifylogisticCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlclassifylogisticCursor::fill(
  self : MlclassifylogisticCursor,
  v : Double,
) -> MlclassifylogisticCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlclassifylogisticCursor::min(self : MlclassifylogisticCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlclassifylogisticCursor::max(self : MlclassifylogisticCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlclassifylogisticCursor::to_string(
  self : MlclassifylogisticCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlclassifylogisticView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_classify_logistic_view_make(size : Int32) -> MlclassifylogisticView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlclassifylogisticView::len(self : MlclassifylogisticView) -> Int32 {
  self.size
}

///|
pub fn MlclassifylogisticView::get(
  self : MlclassifylogisticView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlclassifylogisticView::set(
  self : MlclassifylogisticView,
  i : Int32,
  v : Double,
) -> MlclassifylogisticView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlclassifylogisticView::sum(self : MlclassifylogisticView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlclassifylogisticView::mean(self : MlclassifylogisticView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlclassifylogisticView::scale(
  self : MlclassifylogisticView,
  f : Double,
) -> MlclassifylogisticView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlclassifylogisticView::add(
  self : MlclassifylogisticView,
  other : MlclassifylogisticView,
) -> MlclassifylogisticView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlclassifylogisticView::copy(
  self : MlclassifylogisticView,
) -> MlclassifylogisticView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlclassifylogisticView::fill(
  self : MlclassifylogisticView,
  v : Double,
) -> MlclassifylogisticView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlclassifylogisticView::min(self : MlclassifylogisticView) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlclassifylogisticView::max(self : MlclassifylogisticView) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlclassifylogisticView::to_string(
  self : MlclassifylogisticView,
) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlclassifylogisticRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_classify_logistic_range_make(size : Int32) -> MlclassifylogisticRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlclassifylogisticRange::len(self : MlclassifylogisticRange) -> Int32 {
  self.size
}

///|
pub fn MlclassifylogisticRange::get(
  self : MlclassifylogisticRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlclassifylogisticRange::set(
  self : MlclassifylogisticRange,
  i : Int32,
  v : Double,
) -> MlclassifylogisticRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlclassifylogisticRange::sum(self : MlclassifylogisticRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlclassifylogisticRange::mean(self : MlclassifylogisticRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlclassifylogisticRange::scale(
  self : MlclassifylogisticRange,
  f : Double,
) -> MlclassifylogisticRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlclassifylogisticRange::add(
  self : MlclassifylogisticRange,
  other : MlclassifylogisticRange,
) -> MlclassifylogisticRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlclassifylogisticRange::copy(
  self : MlclassifylogisticRange,
) -> MlclassifylogisticRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlclassifylogisticRange::fill(
  self : MlclassifylogisticRange,
  v : Double,
) -> MlclassifylogisticRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlclassifylogisticRange::min(self : MlclassifylogisticRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlclassifylogisticRange::max(self : MlclassifylogisticRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlclassifylogisticRange::to_string(
  self : MlclassifylogisticRange,
) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlclassifylogisticSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_classify_logistic_slice_make(size : Int32) -> MlclassifylogisticSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlclassifylogisticSlice::len(self : MlclassifylogisticSlice) -> Int32 {
  self.size
}

///|
pub fn MlclassifylogisticSlice::get(
  self : MlclassifylogisticSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlclassifylogisticSlice::set(
  self : MlclassifylogisticSlice,
  i : Int32,
  v : Double,
) -> MlclassifylogisticSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlclassifylogisticSlice::sum(self : MlclassifylogisticSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlclassifylogisticSlice::mean(self : MlclassifylogisticSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlclassifylogisticSlice::scale(
  self : MlclassifylogisticSlice,
  f : Double,
) -> MlclassifylogisticSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlclassifylogisticSlice::add(
  self : MlclassifylogisticSlice,
  other : MlclassifylogisticSlice,
) -> MlclassifylogisticSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlclassifylogisticSlice::copy(
  self : MlclassifylogisticSlice,
) -> MlclassifylogisticSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlclassifylogisticSlice::fill(
  self : MlclassifylogisticSlice,
  v : Double,
) -> MlclassifylogisticSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlclassifylogisticSlice::min(self : MlclassifylogisticSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlclassifylogisticSlice::max(self : MlclassifylogisticSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlclassifylogisticSlice::to_string(
  self : MlclassifylogisticSlice,
) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
