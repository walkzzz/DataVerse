///|
///===
/// extcore/ml_cluster_affinity
pub(all) struct MlclusteraffinityPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn ml_cluster_affinity_make_point(
  x : Double,
  y : Double,
) -> MlclusteraffinityPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn ml_cluster_affinity_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> MlclusteraffinityPoint {
  { x, y, z, label: 0, }
}

///|
pub fn MlclusteraffinityPoint::x(self : MlclusteraffinityPoint) -> Double {
  self.x
}

///|
pub fn MlclusteraffinityPoint::y(self : MlclusteraffinityPoint) -> Double {
  self.y
}

///|
pub fn MlclusteraffinityPoint::z(self : MlclusteraffinityPoint) -> Double {
  self.z
}

///|
pub fn MlclusteraffinityPoint::label(self : MlclusteraffinityPoint) -> Int32 {
  self.label
}

///|
pub fn MlclusteraffinityPoint::dist(
  self : MlclusteraffinityPoint,
  other : MlclusteraffinityPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn MlclusteraffinityPoint::add(
  self : MlclusteraffinityPoint,
  other : MlclusteraffinityPoint,
) -> MlclusteraffinityPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn MlclusteraffinityPoint::sub(
  self : MlclusteraffinityPoint,
  other : MlclusteraffinityPoint,
) -> MlclusteraffinityPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn MlclusteraffinityPoint::scale(
  self : MlclusteraffinityPoint,
  s : Double,
) -> MlclusteraffinityPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn MlclusteraffinityPoint::dot(
  self : MlclusteraffinityPoint,
  other : MlclusteraffinityPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn MlclusteraffinityPoint::cross(
  self : MlclusteraffinityPoint,
  other : MlclusteraffinityPoint,
) -> MlclusteraffinityPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn MlclusteraffinityPoint::norm(self : MlclusteraffinityPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn MlclusteraffinityPoint::normalize(
  self : MlclusteraffinityPoint,
) -> MlclusteraffinityPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn MlclusteraffinityPoint::negate(
  self : MlclusteraffinityPoint,
) -> MlclusteraffinityPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn MlclusteraffinityPoint::mid(
  self : MlclusteraffinityPoint,
  other : MlclusteraffinityPoint,
) -> MlclusteraffinityPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn MlclusteraffinityPoint::lerp(
  self : MlclusteraffinityPoint,
  other : MlclusteraffinityPoint,
  t : Double,
) -> MlclusteraffinityPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn MlclusteraffinityPoint::to_string(
  self : MlclusteraffinityPoint,
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
pub(all) struct MlclusteraffinitySeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn ml_cluster_affinity_make_series(
  vals : Array[Double],
  name : String,
) -> MlclusteraffinitySeries {
  { vals, name, meta: 0, }
}

///|
pub fn MlclusteraffinitySeries::len(self : MlclusteraffinitySeries) -> Int32 {
  self.vals.length()
}

///|
pub fn MlclusteraffinitySeries::sum(self : MlclusteraffinitySeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn MlclusteraffinitySeries::mean(self : MlclusteraffinitySeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn MlclusteraffinitySeries::min(self : MlclusteraffinitySeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn MlclusteraffinitySeries::max(self : MlclusteraffinitySeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn MlclusteraffinitySeries::range(self : MlclusteraffinitySeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn MlclusteraffinitySeries::variance(
  self : MlclusteraffinitySeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn MlclusteraffinitySeries::std(self : MlclusteraffinitySeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn MlclusteraffinitySeries::median(
  self : MlclusteraffinitySeries,
) -> Double {
  @_common.median(self.vals)
}

///|
pub fn MlclusteraffinitySeries::scale(
  self : MlclusteraffinitySeries,
  f : Double,
) -> MlclusteraffinitySeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn MlclusteraffinitySeries::add(
  self : MlclusteraffinitySeries,
  other : MlclusteraffinitySeries,
) -> MlclusteraffinitySeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn MlclusteraffinitySeries::sub(
  self : MlclusteraffinitySeries,
  other : MlclusteraffinitySeries,
) -> MlclusteraffinitySeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn MlclusteraffinitySeries::normalize(
  self : MlclusteraffinitySeries,
) -> MlclusteraffinitySeries {
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
pub fn MlclusteraffinitySeries::cumsum(
  self : MlclusteraffinitySeries,
) -> MlclusteraffinitySeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn MlclusteraffinitySeries::to_string(
  self : MlclusteraffinitySeries,
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
pub(all) struct MlclusteraffinityMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn ml_cluster_affinity_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> MlclusteraffinityMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn ml_cluster_affinity_matrix_identity(
  n : Int32,
) -> MlclusteraffinityMatrix {
  let m = ml_cluster_affinity_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn MlclusteraffinityMatrix::get(
  self : MlclusteraffinityMatrix,
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
pub fn MlclusteraffinityMatrix::transpose(
  self : MlclusteraffinityMatrix,
) -> MlclusteraffinityMatrix {
  let result = ml_cluster_affinity_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn MlclusteraffinityMatrix::add(
  self : MlclusteraffinityMatrix,
  other : MlclusteraffinityMatrix,
) -> MlclusteraffinityMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = ml_cluster_affinity_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn MlclusteraffinityMatrix::scale(
  self : MlclusteraffinityMatrix,
  s : Double,
) -> MlclusteraffinityMatrix {
  let result = ml_cluster_affinity_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn MlclusteraffinityMatrix::multiply(
  self : MlclusteraffinityMatrix,
  other : MlclusteraffinityMatrix,
) -> MlclusteraffinityMatrix {
  if self.cols != other.rows {
    return ml_cluster_affinity_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = ml_cluster_affinity_make_matrix(self.rows, other.cols, 0.0)
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
pub fn MlclusteraffinityMatrix::trace(self : MlclusteraffinityMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn MlclusteraffinityMatrix::det(self : MlclusteraffinityMatrix) -> Double {
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
pub fn MlclusteraffinityMatrix::norm(self : MlclusteraffinityMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn MlclusteraffinityMatrix::to_string(
  self : MlclusteraffinityMatrix,
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
pub(all) struct MlclusteraffinityVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn ml_cluster_affinity_make_vector(
  comps : Array[Double],
) -> MlclusteraffinityVector {
  { comps, dim: comps.length(), }
}

///|
pub fn ml_cluster_affinity_vector_zero(dim : Int32) -> MlclusteraffinityVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn MlclusteraffinityVector::add(
  self : MlclusteraffinityVector,
  other : MlclusteraffinityVector,
) -> MlclusteraffinityVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn MlclusteraffinityVector::sub(
  self : MlclusteraffinityVector,
  other : MlclusteraffinityVector,
) -> MlclusteraffinityVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn MlclusteraffinityVector::scale(
  self : MlclusteraffinityVector,
  s : Double,
) -> MlclusteraffinityVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn MlclusteraffinityVector::dot(
  self : MlclusteraffinityVector,
  other : MlclusteraffinityVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn MlclusteraffinityVector::norm(self : MlclusteraffinityVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn MlclusteraffinityVector::normalize(
  self : MlclusteraffinityVector,
) -> MlclusteraffinityVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn MlclusteraffinityVector::dist(
  self : MlclusteraffinityVector,
  other : MlclusteraffinityVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn MlclusteraffinityVector::to_string(
  self : MlclusteraffinityVector,
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
pub(all) struct MlclusteraffinityFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_cluster_affinity_frame_make(size : Int32) -> MlclusteraffinityFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlclusteraffinityFrame::len(self : MlclusteraffinityFrame) -> Int32 {
  self.size
}

///|
pub fn MlclusteraffinityFrame::get(
  self : MlclusteraffinityFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlclusteraffinityFrame::set(
  self : MlclusteraffinityFrame,
  i : Int32,
  v : Double,
) -> MlclusteraffinityFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlclusteraffinityFrame::sum(self : MlclusteraffinityFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlclusteraffinityFrame::mean(self : MlclusteraffinityFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlclusteraffinityFrame::scale(
  self : MlclusteraffinityFrame,
  f : Double,
) -> MlclusteraffinityFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusteraffinityFrame::add(
  self : MlclusteraffinityFrame,
  other : MlclusteraffinityFrame,
) -> MlclusteraffinityFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlclusteraffinityFrame::copy(
  self : MlclusteraffinityFrame,
) -> MlclusteraffinityFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusteraffinityFrame::fill(
  self : MlclusteraffinityFrame,
  v : Double,
) -> MlclusteraffinityFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusteraffinityFrame::min(self : MlclusteraffinityFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlclusteraffinityFrame::max(self : MlclusteraffinityFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlclusteraffinityFrame::to_string(
  self : MlclusteraffinityFrame,
) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlclusteraffinityTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_cluster_affinity_table_make(size : Int32) -> MlclusteraffinityTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlclusteraffinityTable::len(self : MlclusteraffinityTable) -> Int32 {
  self.size
}

///|
pub fn MlclusteraffinityTable::get(
  self : MlclusteraffinityTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlclusteraffinityTable::set(
  self : MlclusteraffinityTable,
  i : Int32,
  v : Double,
) -> MlclusteraffinityTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlclusteraffinityTable::sum(self : MlclusteraffinityTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlclusteraffinityTable::mean(self : MlclusteraffinityTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlclusteraffinityTable::scale(
  self : MlclusteraffinityTable,
  f : Double,
) -> MlclusteraffinityTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusteraffinityTable::add(
  self : MlclusteraffinityTable,
  other : MlclusteraffinityTable,
) -> MlclusteraffinityTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlclusteraffinityTable::copy(
  self : MlclusteraffinityTable,
) -> MlclusteraffinityTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusteraffinityTable::fill(
  self : MlclusteraffinityTable,
  v : Double,
) -> MlclusteraffinityTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusteraffinityTable::min(self : MlclusteraffinityTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlclusteraffinityTable::max(self : MlclusteraffinityTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlclusteraffinityTable::to_string(
  self : MlclusteraffinityTable,
) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlclusteraffinityGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_cluster_affinity_graphn_make(size : Int32) -> MlclusteraffinityGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlclusteraffinityGraphN::len(self : MlclusteraffinityGraphN) -> Int32 {
  self.size
}

///|
pub fn MlclusteraffinityGraphN::get(
  self : MlclusteraffinityGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlclusteraffinityGraphN::set(
  self : MlclusteraffinityGraphN,
  i : Int32,
  v : Double,
) -> MlclusteraffinityGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlclusteraffinityGraphN::sum(self : MlclusteraffinityGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlclusteraffinityGraphN::mean(self : MlclusteraffinityGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlclusteraffinityGraphN::scale(
  self : MlclusteraffinityGraphN,
  f : Double,
) -> MlclusteraffinityGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusteraffinityGraphN::add(
  self : MlclusteraffinityGraphN,
  other : MlclusteraffinityGraphN,
) -> MlclusteraffinityGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlclusteraffinityGraphN::copy(
  self : MlclusteraffinityGraphN,
) -> MlclusteraffinityGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusteraffinityGraphN::fill(
  self : MlclusteraffinityGraphN,
  v : Double,
) -> MlclusteraffinityGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusteraffinityGraphN::min(self : MlclusteraffinityGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlclusteraffinityGraphN::max(self : MlclusteraffinityGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlclusteraffinityGraphN::to_string(
  self : MlclusteraffinityGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlclusteraffinityNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_cluster_affinity_node_make(size : Int32) -> MlclusteraffinityNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlclusteraffinityNode::len(self : MlclusteraffinityNode) -> Int32 {
  self.size
}

///|
pub fn MlclusteraffinityNode::get(
  self : MlclusteraffinityNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlclusteraffinityNode::set(
  self : MlclusteraffinityNode,
  i : Int32,
  v : Double,
) -> MlclusteraffinityNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlclusteraffinityNode::sum(self : MlclusteraffinityNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlclusteraffinityNode::mean(self : MlclusteraffinityNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlclusteraffinityNode::scale(
  self : MlclusteraffinityNode,
  f : Double,
) -> MlclusteraffinityNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusteraffinityNode::add(
  self : MlclusteraffinityNode,
  other : MlclusteraffinityNode,
) -> MlclusteraffinityNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlclusteraffinityNode::copy(
  self : MlclusteraffinityNode,
) -> MlclusteraffinityNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusteraffinityNode::fill(
  self : MlclusteraffinityNode,
  v : Double,
) -> MlclusteraffinityNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusteraffinityNode::min(self : MlclusteraffinityNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlclusteraffinityNode::max(self : MlclusteraffinityNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlclusteraffinityNode::to_string(self : MlclusteraffinityNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlclusteraffinityEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_cluster_affinity_edge_make(size : Int32) -> MlclusteraffinityEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlclusteraffinityEdge::len(self : MlclusteraffinityEdge) -> Int32 {
  self.size
}

///|
pub fn MlclusteraffinityEdge::get(
  self : MlclusteraffinityEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlclusteraffinityEdge::set(
  self : MlclusteraffinityEdge,
  i : Int32,
  v : Double,
) -> MlclusteraffinityEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlclusteraffinityEdge::sum(self : MlclusteraffinityEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlclusteraffinityEdge::mean(self : MlclusteraffinityEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlclusteraffinityEdge::scale(
  self : MlclusteraffinityEdge,
  f : Double,
) -> MlclusteraffinityEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusteraffinityEdge::add(
  self : MlclusteraffinityEdge,
  other : MlclusteraffinityEdge,
) -> MlclusteraffinityEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlclusteraffinityEdge::copy(
  self : MlclusteraffinityEdge,
) -> MlclusteraffinityEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusteraffinityEdge::fill(
  self : MlclusteraffinityEdge,
  v : Double,
) -> MlclusteraffinityEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusteraffinityEdge::min(self : MlclusteraffinityEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlclusteraffinityEdge::max(self : MlclusteraffinityEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlclusteraffinityEdge::to_string(self : MlclusteraffinityEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlclusteraffinityPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_cluster_affinity_path_make(size : Int32) -> MlclusteraffinityPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlclusteraffinityPath::len(self : MlclusteraffinityPath) -> Int32 {
  self.size
}

///|
pub fn MlclusteraffinityPath::get(
  self : MlclusteraffinityPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlclusteraffinityPath::set(
  self : MlclusteraffinityPath,
  i : Int32,
  v : Double,
) -> MlclusteraffinityPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlclusteraffinityPath::sum(self : MlclusteraffinityPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlclusteraffinityPath::mean(self : MlclusteraffinityPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlclusteraffinityPath::scale(
  self : MlclusteraffinityPath,
  f : Double,
) -> MlclusteraffinityPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusteraffinityPath::add(
  self : MlclusteraffinityPath,
  other : MlclusteraffinityPath,
) -> MlclusteraffinityPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlclusteraffinityPath::copy(
  self : MlclusteraffinityPath,
) -> MlclusteraffinityPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusteraffinityPath::fill(
  self : MlclusteraffinityPath,
  v : Double,
) -> MlclusteraffinityPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusteraffinityPath::min(self : MlclusteraffinityPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlclusteraffinityPath::max(self : MlclusteraffinityPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlclusteraffinityPath::to_string(self : MlclusteraffinityPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlclusteraffinityCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_cluster_affinity_cluster_make(
  size : Int32,
) -> MlclusteraffinityCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlclusteraffinityCluster::len(self : MlclusteraffinityCluster) -> Int32 {
  self.size
}

///|
pub fn MlclusteraffinityCluster::get(
  self : MlclusteraffinityCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlclusteraffinityCluster::set(
  self : MlclusteraffinityCluster,
  i : Int32,
  v : Double,
) -> MlclusteraffinityCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlclusteraffinityCluster::sum(self : MlclusteraffinityCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlclusteraffinityCluster::mean(
  self : MlclusteraffinityCluster,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlclusteraffinityCluster::scale(
  self : MlclusteraffinityCluster,
  f : Double,
) -> MlclusteraffinityCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusteraffinityCluster::add(
  self : MlclusteraffinityCluster,
  other : MlclusteraffinityCluster,
) -> MlclusteraffinityCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlclusteraffinityCluster::copy(
  self : MlclusteraffinityCluster,
) -> MlclusteraffinityCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusteraffinityCluster::fill(
  self : MlclusteraffinityCluster,
  v : Double,
) -> MlclusteraffinityCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusteraffinityCluster::min(self : MlclusteraffinityCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlclusteraffinityCluster::max(self : MlclusteraffinityCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlclusteraffinityCluster::to_string(
  self : MlclusteraffinityCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlclusteraffinityModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_cluster_affinity_model_make(size : Int32) -> MlclusteraffinityModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlclusteraffinityModel::len(self : MlclusteraffinityModel) -> Int32 {
  self.size
}

///|
pub fn MlclusteraffinityModel::get(
  self : MlclusteraffinityModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlclusteraffinityModel::set(
  self : MlclusteraffinityModel,
  i : Int32,
  v : Double,
) -> MlclusteraffinityModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlclusteraffinityModel::sum(self : MlclusteraffinityModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlclusteraffinityModel::mean(self : MlclusteraffinityModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlclusteraffinityModel::scale(
  self : MlclusteraffinityModel,
  f : Double,
) -> MlclusteraffinityModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusteraffinityModel::add(
  self : MlclusteraffinityModel,
  other : MlclusteraffinityModel,
) -> MlclusteraffinityModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlclusteraffinityModel::copy(
  self : MlclusteraffinityModel,
) -> MlclusteraffinityModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusteraffinityModel::fill(
  self : MlclusteraffinityModel,
  v : Double,
) -> MlclusteraffinityModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusteraffinityModel::min(self : MlclusteraffinityModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlclusteraffinityModel::max(self : MlclusteraffinityModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlclusteraffinityModel::to_string(
  self : MlclusteraffinityModel,
) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlclusteraffinityLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_cluster_affinity_layer_make(size : Int32) -> MlclusteraffinityLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlclusteraffinityLayer::len(self : MlclusteraffinityLayer) -> Int32 {
  self.size
}

///|
pub fn MlclusteraffinityLayer::get(
  self : MlclusteraffinityLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlclusteraffinityLayer::set(
  self : MlclusteraffinityLayer,
  i : Int32,
  v : Double,
) -> MlclusteraffinityLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlclusteraffinityLayer::sum(self : MlclusteraffinityLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlclusteraffinityLayer::mean(self : MlclusteraffinityLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlclusteraffinityLayer::scale(
  self : MlclusteraffinityLayer,
  f : Double,
) -> MlclusteraffinityLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusteraffinityLayer::add(
  self : MlclusteraffinityLayer,
  other : MlclusteraffinityLayer,
) -> MlclusteraffinityLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlclusteraffinityLayer::copy(
  self : MlclusteraffinityLayer,
) -> MlclusteraffinityLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusteraffinityLayer::fill(
  self : MlclusteraffinityLayer,
  v : Double,
) -> MlclusteraffinityLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusteraffinityLayer::min(self : MlclusteraffinityLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlclusteraffinityLayer::max(self : MlclusteraffinityLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlclusteraffinityLayer::to_string(
  self : MlclusteraffinityLayer,
) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlclusteraffinityBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_cluster_affinity_buffer_make(size : Int32) -> MlclusteraffinityBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlclusteraffinityBuffer::len(self : MlclusteraffinityBuffer) -> Int32 {
  self.size
}

///|
pub fn MlclusteraffinityBuffer::get(
  self : MlclusteraffinityBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlclusteraffinityBuffer::set(
  self : MlclusteraffinityBuffer,
  i : Int32,
  v : Double,
) -> MlclusteraffinityBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlclusteraffinityBuffer::sum(self : MlclusteraffinityBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlclusteraffinityBuffer::mean(self : MlclusteraffinityBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlclusteraffinityBuffer::scale(
  self : MlclusteraffinityBuffer,
  f : Double,
) -> MlclusteraffinityBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusteraffinityBuffer::add(
  self : MlclusteraffinityBuffer,
  other : MlclusteraffinityBuffer,
) -> MlclusteraffinityBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlclusteraffinityBuffer::copy(
  self : MlclusteraffinityBuffer,
) -> MlclusteraffinityBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusteraffinityBuffer::fill(
  self : MlclusteraffinityBuffer,
  v : Double,
) -> MlclusteraffinityBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusteraffinityBuffer::min(self : MlclusteraffinityBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlclusteraffinityBuffer::max(self : MlclusteraffinityBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlclusteraffinityBuffer::to_string(
  self : MlclusteraffinityBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlclusteraffinityCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_cluster_affinity_cursor_make(size : Int32) -> MlclusteraffinityCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlclusteraffinityCursor::len(self : MlclusteraffinityCursor) -> Int32 {
  self.size
}

///|
pub fn MlclusteraffinityCursor::get(
  self : MlclusteraffinityCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlclusteraffinityCursor::set(
  self : MlclusteraffinityCursor,
  i : Int32,
  v : Double,
) -> MlclusteraffinityCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlclusteraffinityCursor::sum(self : MlclusteraffinityCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlclusteraffinityCursor::mean(self : MlclusteraffinityCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlclusteraffinityCursor::scale(
  self : MlclusteraffinityCursor,
  f : Double,
) -> MlclusteraffinityCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusteraffinityCursor::add(
  self : MlclusteraffinityCursor,
  other : MlclusteraffinityCursor,
) -> MlclusteraffinityCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlclusteraffinityCursor::copy(
  self : MlclusteraffinityCursor,
) -> MlclusteraffinityCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusteraffinityCursor::fill(
  self : MlclusteraffinityCursor,
  v : Double,
) -> MlclusteraffinityCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusteraffinityCursor::min(self : MlclusteraffinityCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlclusteraffinityCursor::max(self : MlclusteraffinityCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlclusteraffinityCursor::to_string(
  self : MlclusteraffinityCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlclusteraffinityView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_cluster_affinity_view_make(size : Int32) -> MlclusteraffinityView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlclusteraffinityView::len(self : MlclusteraffinityView) -> Int32 {
  self.size
}

///|
pub fn MlclusteraffinityView::get(
  self : MlclusteraffinityView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlclusteraffinityView::set(
  self : MlclusteraffinityView,
  i : Int32,
  v : Double,
) -> MlclusteraffinityView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlclusteraffinityView::sum(self : MlclusteraffinityView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlclusteraffinityView::mean(self : MlclusteraffinityView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlclusteraffinityView::scale(
  self : MlclusteraffinityView,
  f : Double,
) -> MlclusteraffinityView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusteraffinityView::add(
  self : MlclusteraffinityView,
  other : MlclusteraffinityView,
) -> MlclusteraffinityView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlclusteraffinityView::copy(
  self : MlclusteraffinityView,
) -> MlclusteraffinityView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusteraffinityView::fill(
  self : MlclusteraffinityView,
  v : Double,
) -> MlclusteraffinityView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusteraffinityView::min(self : MlclusteraffinityView) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlclusteraffinityView::max(self : MlclusteraffinityView) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlclusteraffinityView::to_string(self : MlclusteraffinityView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlclusteraffinityRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_cluster_affinity_range_make(size : Int32) -> MlclusteraffinityRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlclusteraffinityRange::len(self : MlclusteraffinityRange) -> Int32 {
  self.size
}

///|
pub fn MlclusteraffinityRange::get(
  self : MlclusteraffinityRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlclusteraffinityRange::set(
  self : MlclusteraffinityRange,
  i : Int32,
  v : Double,
) -> MlclusteraffinityRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlclusteraffinityRange::sum(self : MlclusteraffinityRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlclusteraffinityRange::mean(self : MlclusteraffinityRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlclusteraffinityRange::scale(
  self : MlclusteraffinityRange,
  f : Double,
) -> MlclusteraffinityRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusteraffinityRange::add(
  self : MlclusteraffinityRange,
  other : MlclusteraffinityRange,
) -> MlclusteraffinityRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlclusteraffinityRange::copy(
  self : MlclusteraffinityRange,
) -> MlclusteraffinityRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusteraffinityRange::fill(
  self : MlclusteraffinityRange,
  v : Double,
) -> MlclusteraffinityRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusteraffinityRange::min(self : MlclusteraffinityRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlclusteraffinityRange::max(self : MlclusteraffinityRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlclusteraffinityRange::to_string(
  self : MlclusteraffinityRange,
) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlclusteraffinitySlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_cluster_affinity_slice_make(size : Int32) -> MlclusteraffinitySlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlclusteraffinitySlice::len(self : MlclusteraffinitySlice) -> Int32 {
  self.size
}

///|
pub fn MlclusteraffinitySlice::get(
  self : MlclusteraffinitySlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlclusteraffinitySlice::set(
  self : MlclusteraffinitySlice,
  i : Int32,
  v : Double,
) -> MlclusteraffinitySlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlclusteraffinitySlice::sum(self : MlclusteraffinitySlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlclusteraffinitySlice::mean(self : MlclusteraffinitySlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlclusteraffinitySlice::scale(
  self : MlclusteraffinitySlice,
  f : Double,
) -> MlclusteraffinitySlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusteraffinitySlice::add(
  self : MlclusteraffinitySlice,
  other : MlclusteraffinitySlice,
) -> MlclusteraffinitySlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlclusteraffinitySlice::copy(
  self : MlclusteraffinitySlice,
) -> MlclusteraffinitySlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusteraffinitySlice::fill(
  self : MlclusteraffinitySlice,
  v : Double,
) -> MlclusteraffinitySlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusteraffinitySlice::min(self : MlclusteraffinitySlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlclusteraffinitySlice::max(self : MlclusteraffinitySlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlclusteraffinitySlice::to_string(
  self : MlclusteraffinitySlice,
) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
