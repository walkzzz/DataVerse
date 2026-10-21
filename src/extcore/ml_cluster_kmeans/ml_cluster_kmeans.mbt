///|
///===
/// extcore/ml_cluster_kmeans
pub(all) struct MlclusterkmeansPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn ml_cluster_kmeans_make_point(
  x : Double,
  y : Double,
) -> MlclusterkmeansPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn ml_cluster_kmeans_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> MlclusterkmeansPoint {
  { x, y, z, label: 0, }
}

///|
pub fn MlclusterkmeansPoint::x(self : MlclusterkmeansPoint) -> Double {
  self.x
}

///|
pub fn MlclusterkmeansPoint::y(self : MlclusterkmeansPoint) -> Double {
  self.y
}

///|
pub fn MlclusterkmeansPoint::z(self : MlclusterkmeansPoint) -> Double {
  self.z
}

///|
pub fn MlclusterkmeansPoint::label(self : MlclusterkmeansPoint) -> Int32 {
  self.label
}

///|
pub fn MlclusterkmeansPoint::dist(
  self : MlclusterkmeansPoint,
  other : MlclusterkmeansPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn MlclusterkmeansPoint::add(
  self : MlclusterkmeansPoint,
  other : MlclusterkmeansPoint,
) -> MlclusterkmeansPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn MlclusterkmeansPoint::sub(
  self : MlclusterkmeansPoint,
  other : MlclusterkmeansPoint,
) -> MlclusterkmeansPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn MlclusterkmeansPoint::scale(
  self : MlclusterkmeansPoint,
  s : Double,
) -> MlclusterkmeansPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn MlclusterkmeansPoint::dot(
  self : MlclusterkmeansPoint,
  other : MlclusterkmeansPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn MlclusterkmeansPoint::cross(
  self : MlclusterkmeansPoint,
  other : MlclusterkmeansPoint,
) -> MlclusterkmeansPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn MlclusterkmeansPoint::norm(self : MlclusterkmeansPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn MlclusterkmeansPoint::normalize(
  self : MlclusterkmeansPoint,
) -> MlclusterkmeansPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn MlclusterkmeansPoint::negate(
  self : MlclusterkmeansPoint,
) -> MlclusterkmeansPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn MlclusterkmeansPoint::mid(
  self : MlclusterkmeansPoint,
  other : MlclusterkmeansPoint,
) -> MlclusterkmeansPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn MlclusterkmeansPoint::lerp(
  self : MlclusterkmeansPoint,
  other : MlclusterkmeansPoint,
  t : Double,
) -> MlclusterkmeansPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn MlclusterkmeansPoint::to_string(self : MlclusterkmeansPoint) -> String {
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
pub(all) struct MlclusterkmeansSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn ml_cluster_kmeans_make_series(
  vals : Array[Double],
  name : String,
) -> MlclusterkmeansSeries {
  { vals, name, meta: 0, }
}

///|
pub fn MlclusterkmeansSeries::len(self : MlclusterkmeansSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn MlclusterkmeansSeries::sum(self : MlclusterkmeansSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn MlclusterkmeansSeries::mean(self : MlclusterkmeansSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn MlclusterkmeansSeries::min(self : MlclusterkmeansSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn MlclusterkmeansSeries::max(self : MlclusterkmeansSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn MlclusterkmeansSeries::range(self : MlclusterkmeansSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn MlclusterkmeansSeries::variance(self : MlclusterkmeansSeries) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn MlclusterkmeansSeries::std(self : MlclusterkmeansSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn MlclusterkmeansSeries::median(self : MlclusterkmeansSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn MlclusterkmeansSeries::scale(
  self : MlclusterkmeansSeries,
  f : Double,
) -> MlclusterkmeansSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn MlclusterkmeansSeries::add(
  self : MlclusterkmeansSeries,
  other : MlclusterkmeansSeries,
) -> MlclusterkmeansSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn MlclusterkmeansSeries::sub(
  self : MlclusterkmeansSeries,
  other : MlclusterkmeansSeries,
) -> MlclusterkmeansSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn MlclusterkmeansSeries::normalize(
  self : MlclusterkmeansSeries,
) -> MlclusterkmeansSeries {
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
pub fn MlclusterkmeansSeries::cumsum(
  self : MlclusterkmeansSeries,
) -> MlclusterkmeansSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn MlclusterkmeansSeries::to_string(self : MlclusterkmeansSeries) -> String {
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
pub(all) struct MlclusterkmeansMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn ml_cluster_kmeans_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> MlclusterkmeansMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn ml_cluster_kmeans_matrix_identity(n : Int32) -> MlclusterkmeansMatrix {
  let m = ml_cluster_kmeans_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn MlclusterkmeansMatrix::get(
  self : MlclusterkmeansMatrix,
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
pub fn MlclusterkmeansMatrix::transpose(
  self : MlclusterkmeansMatrix,
) -> MlclusterkmeansMatrix {
  let result = ml_cluster_kmeans_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn MlclusterkmeansMatrix::add(
  self : MlclusterkmeansMatrix,
  other : MlclusterkmeansMatrix,
) -> MlclusterkmeansMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = ml_cluster_kmeans_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn MlclusterkmeansMatrix::scale(
  self : MlclusterkmeansMatrix,
  s : Double,
) -> MlclusterkmeansMatrix {
  let result = ml_cluster_kmeans_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn MlclusterkmeansMatrix::multiply(
  self : MlclusterkmeansMatrix,
  other : MlclusterkmeansMatrix,
) -> MlclusterkmeansMatrix {
  if self.cols != other.rows {
    return ml_cluster_kmeans_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = ml_cluster_kmeans_make_matrix(self.rows, other.cols, 0.0)
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
pub fn MlclusterkmeansMatrix::trace(self : MlclusterkmeansMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn MlclusterkmeansMatrix::det(self : MlclusterkmeansMatrix) -> Double {
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
pub fn MlclusterkmeansMatrix::norm(self : MlclusterkmeansMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn MlclusterkmeansMatrix::to_string(self : MlclusterkmeansMatrix) -> String {
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
pub(all) struct MlclusterkmeansVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn ml_cluster_kmeans_make_vector(
  comps : Array[Double],
) -> MlclusterkmeansVector {
  { comps, dim: comps.length(), }
}

///|
pub fn ml_cluster_kmeans_vector_zero(dim : Int32) -> MlclusterkmeansVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn MlclusterkmeansVector::add(
  self : MlclusterkmeansVector,
  other : MlclusterkmeansVector,
) -> MlclusterkmeansVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn MlclusterkmeansVector::sub(
  self : MlclusterkmeansVector,
  other : MlclusterkmeansVector,
) -> MlclusterkmeansVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn MlclusterkmeansVector::scale(
  self : MlclusterkmeansVector,
  s : Double,
) -> MlclusterkmeansVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn MlclusterkmeansVector::dot(
  self : MlclusterkmeansVector,
  other : MlclusterkmeansVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn MlclusterkmeansVector::norm(self : MlclusterkmeansVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn MlclusterkmeansVector::normalize(
  self : MlclusterkmeansVector,
) -> MlclusterkmeansVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn MlclusterkmeansVector::dist(
  self : MlclusterkmeansVector,
  other : MlclusterkmeansVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn MlclusterkmeansVector::to_string(self : MlclusterkmeansVector) -> String {
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
pub(all) struct MlclusterkmeansFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_cluster_kmeans_frame_make(size : Int32) -> MlclusterkmeansFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlclusterkmeansFrame::len(self : MlclusterkmeansFrame) -> Int32 {
  self.size
}

///|
pub fn MlclusterkmeansFrame::get(
  self : MlclusterkmeansFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlclusterkmeansFrame::set(
  self : MlclusterkmeansFrame,
  i : Int32,
  v : Double,
) -> MlclusterkmeansFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterkmeansFrame::sum(self : MlclusterkmeansFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlclusterkmeansFrame::mean(self : MlclusterkmeansFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlclusterkmeansFrame::scale(
  self : MlclusterkmeansFrame,
  f : Double,
) -> MlclusterkmeansFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterkmeansFrame::add(
  self : MlclusterkmeansFrame,
  other : MlclusterkmeansFrame,
) -> MlclusterkmeansFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlclusterkmeansFrame::copy(
  self : MlclusterkmeansFrame,
) -> MlclusterkmeansFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterkmeansFrame::fill(
  self : MlclusterkmeansFrame,
  v : Double,
) -> MlclusterkmeansFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterkmeansFrame::min(self : MlclusterkmeansFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlclusterkmeansFrame::max(self : MlclusterkmeansFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlclusterkmeansFrame::to_string(self : MlclusterkmeansFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlclusterkmeansTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_cluster_kmeans_table_make(size : Int32) -> MlclusterkmeansTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlclusterkmeansTable::len(self : MlclusterkmeansTable) -> Int32 {
  self.size
}

///|
pub fn MlclusterkmeansTable::get(
  self : MlclusterkmeansTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlclusterkmeansTable::set(
  self : MlclusterkmeansTable,
  i : Int32,
  v : Double,
) -> MlclusterkmeansTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterkmeansTable::sum(self : MlclusterkmeansTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlclusterkmeansTable::mean(self : MlclusterkmeansTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlclusterkmeansTable::scale(
  self : MlclusterkmeansTable,
  f : Double,
) -> MlclusterkmeansTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterkmeansTable::add(
  self : MlclusterkmeansTable,
  other : MlclusterkmeansTable,
) -> MlclusterkmeansTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlclusterkmeansTable::copy(
  self : MlclusterkmeansTable,
) -> MlclusterkmeansTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterkmeansTable::fill(
  self : MlclusterkmeansTable,
  v : Double,
) -> MlclusterkmeansTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterkmeansTable::min(self : MlclusterkmeansTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlclusterkmeansTable::max(self : MlclusterkmeansTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlclusterkmeansTable::to_string(self : MlclusterkmeansTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlclusterkmeansGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_cluster_kmeans_graphn_make(size : Int32) -> MlclusterkmeansGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlclusterkmeansGraphN::len(self : MlclusterkmeansGraphN) -> Int32 {
  self.size
}

///|
pub fn MlclusterkmeansGraphN::get(
  self : MlclusterkmeansGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlclusterkmeansGraphN::set(
  self : MlclusterkmeansGraphN,
  i : Int32,
  v : Double,
) -> MlclusterkmeansGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterkmeansGraphN::sum(self : MlclusterkmeansGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlclusterkmeansGraphN::mean(self : MlclusterkmeansGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlclusterkmeansGraphN::scale(
  self : MlclusterkmeansGraphN,
  f : Double,
) -> MlclusterkmeansGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterkmeansGraphN::add(
  self : MlclusterkmeansGraphN,
  other : MlclusterkmeansGraphN,
) -> MlclusterkmeansGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlclusterkmeansGraphN::copy(
  self : MlclusterkmeansGraphN,
) -> MlclusterkmeansGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterkmeansGraphN::fill(
  self : MlclusterkmeansGraphN,
  v : Double,
) -> MlclusterkmeansGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterkmeansGraphN::min(self : MlclusterkmeansGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlclusterkmeansGraphN::max(self : MlclusterkmeansGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlclusterkmeansGraphN::to_string(self : MlclusterkmeansGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlclusterkmeansNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_cluster_kmeans_node_make(size : Int32) -> MlclusterkmeansNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlclusterkmeansNode::len(self : MlclusterkmeansNode) -> Int32 {
  self.size
}

///|
pub fn MlclusterkmeansNode::get(
  self : MlclusterkmeansNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlclusterkmeansNode::set(
  self : MlclusterkmeansNode,
  i : Int32,
  v : Double,
) -> MlclusterkmeansNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterkmeansNode::sum(self : MlclusterkmeansNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlclusterkmeansNode::mean(self : MlclusterkmeansNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlclusterkmeansNode::scale(
  self : MlclusterkmeansNode,
  f : Double,
) -> MlclusterkmeansNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterkmeansNode::add(
  self : MlclusterkmeansNode,
  other : MlclusterkmeansNode,
) -> MlclusterkmeansNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlclusterkmeansNode::copy(
  self : MlclusterkmeansNode,
) -> MlclusterkmeansNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterkmeansNode::fill(
  self : MlclusterkmeansNode,
  v : Double,
) -> MlclusterkmeansNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterkmeansNode::min(self : MlclusterkmeansNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlclusterkmeansNode::max(self : MlclusterkmeansNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlclusterkmeansNode::to_string(self : MlclusterkmeansNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlclusterkmeansEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_cluster_kmeans_edge_make(size : Int32) -> MlclusterkmeansEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlclusterkmeansEdge::len(self : MlclusterkmeansEdge) -> Int32 {
  self.size
}

///|
pub fn MlclusterkmeansEdge::get(
  self : MlclusterkmeansEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlclusterkmeansEdge::set(
  self : MlclusterkmeansEdge,
  i : Int32,
  v : Double,
) -> MlclusterkmeansEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterkmeansEdge::sum(self : MlclusterkmeansEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlclusterkmeansEdge::mean(self : MlclusterkmeansEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlclusterkmeansEdge::scale(
  self : MlclusterkmeansEdge,
  f : Double,
) -> MlclusterkmeansEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterkmeansEdge::add(
  self : MlclusterkmeansEdge,
  other : MlclusterkmeansEdge,
) -> MlclusterkmeansEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlclusterkmeansEdge::copy(
  self : MlclusterkmeansEdge,
) -> MlclusterkmeansEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterkmeansEdge::fill(
  self : MlclusterkmeansEdge,
  v : Double,
) -> MlclusterkmeansEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterkmeansEdge::min(self : MlclusterkmeansEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlclusterkmeansEdge::max(self : MlclusterkmeansEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlclusterkmeansEdge::to_string(self : MlclusterkmeansEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlclusterkmeansPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_cluster_kmeans_path_make(size : Int32) -> MlclusterkmeansPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlclusterkmeansPath::len(self : MlclusterkmeansPath) -> Int32 {
  self.size
}

///|
pub fn MlclusterkmeansPath::get(
  self : MlclusterkmeansPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlclusterkmeansPath::set(
  self : MlclusterkmeansPath,
  i : Int32,
  v : Double,
) -> MlclusterkmeansPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterkmeansPath::sum(self : MlclusterkmeansPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlclusterkmeansPath::mean(self : MlclusterkmeansPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlclusterkmeansPath::scale(
  self : MlclusterkmeansPath,
  f : Double,
) -> MlclusterkmeansPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterkmeansPath::add(
  self : MlclusterkmeansPath,
  other : MlclusterkmeansPath,
) -> MlclusterkmeansPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlclusterkmeansPath::copy(
  self : MlclusterkmeansPath,
) -> MlclusterkmeansPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterkmeansPath::fill(
  self : MlclusterkmeansPath,
  v : Double,
) -> MlclusterkmeansPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterkmeansPath::min(self : MlclusterkmeansPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlclusterkmeansPath::max(self : MlclusterkmeansPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlclusterkmeansPath::to_string(self : MlclusterkmeansPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlclusterkmeansCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_cluster_kmeans_cluster_make(size : Int32) -> MlclusterkmeansCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlclusterkmeansCluster::len(self : MlclusterkmeansCluster) -> Int32 {
  self.size
}

///|
pub fn MlclusterkmeansCluster::get(
  self : MlclusterkmeansCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlclusterkmeansCluster::set(
  self : MlclusterkmeansCluster,
  i : Int32,
  v : Double,
) -> MlclusterkmeansCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterkmeansCluster::sum(self : MlclusterkmeansCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlclusterkmeansCluster::mean(self : MlclusterkmeansCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlclusterkmeansCluster::scale(
  self : MlclusterkmeansCluster,
  f : Double,
) -> MlclusterkmeansCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterkmeansCluster::add(
  self : MlclusterkmeansCluster,
  other : MlclusterkmeansCluster,
) -> MlclusterkmeansCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlclusterkmeansCluster::copy(
  self : MlclusterkmeansCluster,
) -> MlclusterkmeansCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterkmeansCluster::fill(
  self : MlclusterkmeansCluster,
  v : Double,
) -> MlclusterkmeansCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterkmeansCluster::min(self : MlclusterkmeansCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlclusterkmeansCluster::max(self : MlclusterkmeansCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlclusterkmeansCluster::to_string(
  self : MlclusterkmeansCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlclusterkmeansModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_cluster_kmeans_model_make(size : Int32) -> MlclusterkmeansModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlclusterkmeansModel::len(self : MlclusterkmeansModel) -> Int32 {
  self.size
}

///|
pub fn MlclusterkmeansModel::get(
  self : MlclusterkmeansModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlclusterkmeansModel::set(
  self : MlclusterkmeansModel,
  i : Int32,
  v : Double,
) -> MlclusterkmeansModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterkmeansModel::sum(self : MlclusterkmeansModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlclusterkmeansModel::mean(self : MlclusterkmeansModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlclusterkmeansModel::scale(
  self : MlclusterkmeansModel,
  f : Double,
) -> MlclusterkmeansModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterkmeansModel::add(
  self : MlclusterkmeansModel,
  other : MlclusterkmeansModel,
) -> MlclusterkmeansModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlclusterkmeansModel::copy(
  self : MlclusterkmeansModel,
) -> MlclusterkmeansModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterkmeansModel::fill(
  self : MlclusterkmeansModel,
  v : Double,
) -> MlclusterkmeansModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterkmeansModel::min(self : MlclusterkmeansModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlclusterkmeansModel::max(self : MlclusterkmeansModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlclusterkmeansModel::to_string(self : MlclusterkmeansModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlclusterkmeansLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_cluster_kmeans_layer_make(size : Int32) -> MlclusterkmeansLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlclusterkmeansLayer::len(self : MlclusterkmeansLayer) -> Int32 {
  self.size
}

///|
pub fn MlclusterkmeansLayer::get(
  self : MlclusterkmeansLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlclusterkmeansLayer::set(
  self : MlclusterkmeansLayer,
  i : Int32,
  v : Double,
) -> MlclusterkmeansLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterkmeansLayer::sum(self : MlclusterkmeansLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlclusterkmeansLayer::mean(self : MlclusterkmeansLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlclusterkmeansLayer::scale(
  self : MlclusterkmeansLayer,
  f : Double,
) -> MlclusterkmeansLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterkmeansLayer::add(
  self : MlclusterkmeansLayer,
  other : MlclusterkmeansLayer,
) -> MlclusterkmeansLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlclusterkmeansLayer::copy(
  self : MlclusterkmeansLayer,
) -> MlclusterkmeansLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterkmeansLayer::fill(
  self : MlclusterkmeansLayer,
  v : Double,
) -> MlclusterkmeansLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterkmeansLayer::min(self : MlclusterkmeansLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlclusterkmeansLayer::max(self : MlclusterkmeansLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlclusterkmeansLayer::to_string(self : MlclusterkmeansLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlclusterkmeansBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_cluster_kmeans_buffer_make(size : Int32) -> MlclusterkmeansBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlclusterkmeansBuffer::len(self : MlclusterkmeansBuffer) -> Int32 {
  self.size
}

///|
pub fn MlclusterkmeansBuffer::get(
  self : MlclusterkmeansBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlclusterkmeansBuffer::set(
  self : MlclusterkmeansBuffer,
  i : Int32,
  v : Double,
) -> MlclusterkmeansBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterkmeansBuffer::sum(self : MlclusterkmeansBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlclusterkmeansBuffer::mean(self : MlclusterkmeansBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlclusterkmeansBuffer::scale(
  self : MlclusterkmeansBuffer,
  f : Double,
) -> MlclusterkmeansBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterkmeansBuffer::add(
  self : MlclusterkmeansBuffer,
  other : MlclusterkmeansBuffer,
) -> MlclusterkmeansBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlclusterkmeansBuffer::copy(
  self : MlclusterkmeansBuffer,
) -> MlclusterkmeansBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterkmeansBuffer::fill(
  self : MlclusterkmeansBuffer,
  v : Double,
) -> MlclusterkmeansBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterkmeansBuffer::min(self : MlclusterkmeansBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlclusterkmeansBuffer::max(self : MlclusterkmeansBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlclusterkmeansBuffer::to_string(self : MlclusterkmeansBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlclusterkmeansCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_cluster_kmeans_cursor_make(size : Int32) -> MlclusterkmeansCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlclusterkmeansCursor::len(self : MlclusterkmeansCursor) -> Int32 {
  self.size
}

///|
pub fn MlclusterkmeansCursor::get(
  self : MlclusterkmeansCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlclusterkmeansCursor::set(
  self : MlclusterkmeansCursor,
  i : Int32,
  v : Double,
) -> MlclusterkmeansCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterkmeansCursor::sum(self : MlclusterkmeansCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlclusterkmeansCursor::mean(self : MlclusterkmeansCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlclusterkmeansCursor::scale(
  self : MlclusterkmeansCursor,
  f : Double,
) -> MlclusterkmeansCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterkmeansCursor::add(
  self : MlclusterkmeansCursor,
  other : MlclusterkmeansCursor,
) -> MlclusterkmeansCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlclusterkmeansCursor::copy(
  self : MlclusterkmeansCursor,
) -> MlclusterkmeansCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterkmeansCursor::fill(
  self : MlclusterkmeansCursor,
  v : Double,
) -> MlclusterkmeansCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterkmeansCursor::min(self : MlclusterkmeansCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlclusterkmeansCursor::max(self : MlclusterkmeansCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlclusterkmeansCursor::to_string(self : MlclusterkmeansCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlclusterkmeansView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_cluster_kmeans_view_make(size : Int32) -> MlclusterkmeansView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlclusterkmeansView::len(self : MlclusterkmeansView) -> Int32 {
  self.size
}

///|
pub fn MlclusterkmeansView::get(
  self : MlclusterkmeansView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlclusterkmeansView::set(
  self : MlclusterkmeansView,
  i : Int32,
  v : Double,
) -> MlclusterkmeansView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterkmeansView::sum(self : MlclusterkmeansView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlclusterkmeansView::mean(self : MlclusterkmeansView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlclusterkmeansView::scale(
  self : MlclusterkmeansView,
  f : Double,
) -> MlclusterkmeansView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterkmeansView::add(
  self : MlclusterkmeansView,
  other : MlclusterkmeansView,
) -> MlclusterkmeansView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlclusterkmeansView::copy(
  self : MlclusterkmeansView,
) -> MlclusterkmeansView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterkmeansView::fill(
  self : MlclusterkmeansView,
  v : Double,
) -> MlclusterkmeansView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterkmeansView::min(self : MlclusterkmeansView) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlclusterkmeansView::max(self : MlclusterkmeansView) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlclusterkmeansView::to_string(self : MlclusterkmeansView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlclusterkmeansRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_cluster_kmeans_range_make(size : Int32) -> MlclusterkmeansRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlclusterkmeansRange::len(self : MlclusterkmeansRange) -> Int32 {
  self.size
}

///|
pub fn MlclusterkmeansRange::get(
  self : MlclusterkmeansRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlclusterkmeansRange::set(
  self : MlclusterkmeansRange,
  i : Int32,
  v : Double,
) -> MlclusterkmeansRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterkmeansRange::sum(self : MlclusterkmeansRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlclusterkmeansRange::mean(self : MlclusterkmeansRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlclusterkmeansRange::scale(
  self : MlclusterkmeansRange,
  f : Double,
) -> MlclusterkmeansRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterkmeansRange::add(
  self : MlclusterkmeansRange,
  other : MlclusterkmeansRange,
) -> MlclusterkmeansRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlclusterkmeansRange::copy(
  self : MlclusterkmeansRange,
) -> MlclusterkmeansRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterkmeansRange::fill(
  self : MlclusterkmeansRange,
  v : Double,
) -> MlclusterkmeansRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterkmeansRange::min(self : MlclusterkmeansRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlclusterkmeansRange::max(self : MlclusterkmeansRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlclusterkmeansRange::to_string(self : MlclusterkmeansRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlclusterkmeansSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_cluster_kmeans_slice_make(size : Int32) -> MlclusterkmeansSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlclusterkmeansSlice::len(self : MlclusterkmeansSlice) -> Int32 {
  self.size
}

///|
pub fn MlclusterkmeansSlice::get(
  self : MlclusterkmeansSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlclusterkmeansSlice::set(
  self : MlclusterkmeansSlice,
  i : Int32,
  v : Double,
) -> MlclusterkmeansSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterkmeansSlice::sum(self : MlclusterkmeansSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlclusterkmeansSlice::mean(self : MlclusterkmeansSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlclusterkmeansSlice::scale(
  self : MlclusterkmeansSlice,
  f : Double,
) -> MlclusterkmeansSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterkmeansSlice::add(
  self : MlclusterkmeansSlice,
  other : MlclusterkmeansSlice,
) -> MlclusterkmeansSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlclusterkmeansSlice::copy(
  self : MlclusterkmeansSlice,
) -> MlclusterkmeansSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterkmeansSlice::fill(
  self : MlclusterkmeansSlice,
  v : Double,
) -> MlclusterkmeansSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterkmeansSlice::min(self : MlclusterkmeansSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlclusterkmeansSlice::max(self : MlclusterkmeansSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlclusterkmeansSlice::to_string(self : MlclusterkmeansSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
