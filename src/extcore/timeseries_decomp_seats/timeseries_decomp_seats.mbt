///===
/// extcore/timeseries_decomp_seats

pub(all) struct TimeseriesdecompseatsPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_decomp_seats_make_point(x : Double, y : Double) -> TimeseriesdecompseatsPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_decomp_seats_make_point3(x : Double, y : Double, z : Double) -> TimeseriesdecompseatsPoint {
  { x, y, z, label: 0 }
}

pub fn TimeseriesdecompseatsPoint::x(self : TimeseriesdecompseatsPoint) -> Double { self.x }

pub fn TimeseriesdecompseatsPoint::y(self : TimeseriesdecompseatsPoint) -> Double { self.y }

pub fn TimeseriesdecompseatsPoint::z(self : TimeseriesdecompseatsPoint) -> Double { self.z }

pub fn TimeseriesdecompseatsPoint::label(self : TimeseriesdecompseatsPoint) -> Int { self.label }

pub fn TimeseriesdecompseatsPoint::dist(self : TimeseriesdecompseatsPoint, other : TimeseriesdecompseatsPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn TimeseriesdecompseatsPoint::add(self : TimeseriesdecompseatsPoint, other : TimeseriesdecompseatsPoint) -> TimeseriesdecompseatsPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn TimeseriesdecompseatsPoint::sub(self : TimeseriesdecompseatsPoint, other : TimeseriesdecompseatsPoint) -> TimeseriesdecompseatsPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn TimeseriesdecompseatsPoint::scale(self : TimeseriesdecompseatsPoint, s : Double) -> TimeseriesdecompseatsPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn TimeseriesdecompseatsPoint::dot(self : TimeseriesdecompseatsPoint, other : TimeseriesdecompseatsPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn TimeseriesdecompseatsPoint::cross(self : TimeseriesdecompseatsPoint, other : TimeseriesdecompseatsPoint) -> TimeseriesdecompseatsPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn TimeseriesdecompseatsPoint::norm(self : TimeseriesdecompseatsPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn TimeseriesdecompseatsPoint::normalize(self : TimeseriesdecompseatsPoint) -> TimeseriesdecompseatsPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesdecompseatsPoint::negate(self : TimeseriesdecompseatsPoint) -> TimeseriesdecompseatsPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn TimeseriesdecompseatsPoint::mid(self : TimeseriesdecompseatsPoint, other : TimeseriesdecompseatsPoint) -> TimeseriesdecompseatsPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn TimeseriesdecompseatsPoint::lerp(self : TimeseriesdecompseatsPoint, other : TimeseriesdecompseatsPoint, t : Double) -> TimeseriesdecompseatsPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn TimeseriesdecompseatsPoint::to_string(self : TimeseriesdecompseatsPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct TimeseriesdecompseatsSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_decomp_seats_make_series(vals : Array[Double], name : String) -> TimeseriesdecompseatsSeries {
  { vals, name, meta: 0 }
}

pub fn TimeseriesdecompseatsSeries::len(self : TimeseriesdecompseatsSeries) -> Int { self.vals.length() }

pub fn TimeseriesdecompseatsSeries::sum(self : TimeseriesdecompseatsSeries) -> Double { @_common.sum(self.vals) }

pub fn TimeseriesdecompseatsSeries::mean(self : TimeseriesdecompseatsSeries) -> Double { @_common.mean(self.vals) }

pub fn TimeseriesdecompseatsSeries::min(self : TimeseriesdecompseatsSeries) -> Double { @_common.min(self.vals) }

pub fn TimeseriesdecompseatsSeries::max(self : TimeseriesdecompseatsSeries) -> Double { @_common.max(self.vals) }

pub fn TimeseriesdecompseatsSeries::range(self : TimeseriesdecompseatsSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn TimeseriesdecompseatsSeries::variance(self : TimeseriesdecompseatsSeries) -> Double { @_common.variance(self.vals) }

pub fn TimeseriesdecompseatsSeries::std(self : TimeseriesdecompseatsSeries) -> Double { @_common.std(self.vals) }

pub fn TimeseriesdecompseatsSeries::median(self : TimeseriesdecompseatsSeries) -> Double { @_common.median(self.vals) }

pub fn TimeseriesdecompseatsSeries::scale(self : TimeseriesdecompseatsSeries, f : Double) -> TimeseriesdecompseatsSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn TimeseriesdecompseatsSeries::add(self : TimeseriesdecompseatsSeries, other : TimeseriesdecompseatsSeries) -> TimeseriesdecompseatsSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn TimeseriesdecompseatsSeries::sub(self : TimeseriesdecompseatsSeries, other : TimeseriesdecompseatsSeries) -> TimeseriesdecompseatsSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn TimeseriesdecompseatsSeries::normalize(self : TimeseriesdecompseatsSeries) -> TimeseriesdecompseatsSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn TimeseriesdecompseatsSeries::cumsum(self : TimeseriesdecompseatsSeries) -> TimeseriesdecompseatsSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn TimeseriesdecompseatsSeries::to_string(self : TimeseriesdecompseatsSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesdecompseatsMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_decomp_seats_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesdecompseatsMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_decomp_seats_matrix_identity(n : Int) -> TimeseriesdecompseatsMatrix {
  let m = timeseries_decomp_seats_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn TimeseriesdecompseatsMatrix::get(self : TimeseriesdecompseatsMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn TimeseriesdecompseatsMatrix::transpose(self : TimeseriesdecompseatsMatrix) -> TimeseriesdecompseatsMatrix {
  let result = timeseries_decomp_seats_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn TimeseriesdecompseatsMatrix::add(self : TimeseriesdecompseatsMatrix, other : TimeseriesdecompseatsMatrix) -> TimeseriesdecompseatsMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = timeseries_decomp_seats_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn TimeseriesdecompseatsMatrix::scale(self : TimeseriesdecompseatsMatrix, s : Double) -> TimeseriesdecompseatsMatrix {
  let result = timeseries_decomp_seats_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn TimeseriesdecompseatsMatrix::multiply(self : TimeseriesdecompseatsMatrix, other : TimeseriesdecompseatsMatrix) -> TimeseriesdecompseatsMatrix {
  if self.cols != other.rows { return timeseries_decomp_seats_make_matrix(self.rows, other.cols, 0.0) }
  let result = timeseries_decomp_seats_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn TimeseriesdecompseatsMatrix::trace(self : TimeseriesdecompseatsMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn TimeseriesdecompseatsMatrix::det(self : TimeseriesdecompseatsMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn TimeseriesdecompseatsMatrix::norm(self : TimeseriesdecompseatsMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn TimeseriesdecompseatsMatrix::to_string(self : TimeseriesdecompseatsMatrix) -> String {
  let mut result = "Mat(" + self.rows.to_string() + "x" + self.cols.to_string() + ")\n"
  let rl = if self.rows < 5 { self.rows } else { 5 }
  let cl = if self.cols < 5 { self.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + @_common.dbl(self.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct TimeseriesdecompseatsVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_decomp_seats_make_vector(comps : Array[Double]) -> TimeseriesdecompseatsVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_decomp_seats_vector_zero(dim : Int) -> TimeseriesdecompseatsVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn TimeseriesdecompseatsVector::add(self : TimeseriesdecompseatsVector, other : TimeseriesdecompseatsVector) -> TimeseriesdecompseatsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesdecompseatsVector::sub(self : TimeseriesdecompseatsVector, other : TimeseriesdecompseatsVector) -> TimeseriesdecompseatsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesdecompseatsVector::scale(self : TimeseriesdecompseatsVector, s : Double) -> TimeseriesdecompseatsVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn TimeseriesdecompseatsVector::dot(self : TimeseriesdecompseatsVector, other : TimeseriesdecompseatsVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn TimeseriesdecompseatsVector::norm(self : TimeseriesdecompseatsVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn TimeseriesdecompseatsVector::normalize(self : TimeseriesdecompseatsVector) -> TimeseriesdecompseatsVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesdecompseatsVector::dist(self : TimeseriesdecompseatsVector, other : TimeseriesdecompseatsVector) -> Double {
  self.sub(other).norm()
}

pub fn TimeseriesdecompseatsVector::to_string(self : TimeseriesdecompseatsVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesdecompseatsFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_seats_frame_make(size : Int) -> TimeseriesdecompseatsFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompseatsFrame::len(self : TimeseriesdecompseatsFrame) -> Int { self.size }

pub fn TimeseriesdecompseatsFrame::get(self : TimeseriesdecompseatsFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompseatsFrame::set(self : TimeseriesdecompseatsFrame, i : Int, v : Double) -> TimeseriesdecompseatsFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompseatsFrame::sum(self : TimeseriesdecompseatsFrame) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompseatsFrame::mean(self : TimeseriesdecompseatsFrame) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompseatsFrame::scale(self : TimeseriesdecompseatsFrame, f : Double) -> TimeseriesdecompseatsFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompseatsFrame::add(self : TimeseriesdecompseatsFrame, other : TimeseriesdecompseatsFrame) -> TimeseriesdecompseatsFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompseatsFrame::copy(self : TimeseriesdecompseatsFrame) -> TimeseriesdecompseatsFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompseatsFrame::fill(self : TimeseriesdecompseatsFrame, v : Double) -> TimeseriesdecompseatsFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompseatsFrame::min(self : TimeseriesdecompseatsFrame) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompseatsFrame::max(self : TimeseriesdecompseatsFrame) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompseatsFrame::to_string(self : TimeseriesdecompseatsFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompseatsTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_seats_table_make(size : Int) -> TimeseriesdecompseatsTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompseatsTable::len(self : TimeseriesdecompseatsTable) -> Int { self.size }

pub fn TimeseriesdecompseatsTable::get(self : TimeseriesdecompseatsTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompseatsTable::set(self : TimeseriesdecompseatsTable, i : Int, v : Double) -> TimeseriesdecompseatsTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompseatsTable::sum(self : TimeseriesdecompseatsTable) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompseatsTable::mean(self : TimeseriesdecompseatsTable) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompseatsTable::scale(self : TimeseriesdecompseatsTable, f : Double) -> TimeseriesdecompseatsTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompseatsTable::add(self : TimeseriesdecompseatsTable, other : TimeseriesdecompseatsTable) -> TimeseriesdecompseatsTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompseatsTable::copy(self : TimeseriesdecompseatsTable) -> TimeseriesdecompseatsTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompseatsTable::fill(self : TimeseriesdecompseatsTable, v : Double) -> TimeseriesdecompseatsTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompseatsTable::min(self : TimeseriesdecompseatsTable) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompseatsTable::max(self : TimeseriesdecompseatsTable) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompseatsTable::to_string(self : TimeseriesdecompseatsTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompseatsGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_seats_graphn_make(size : Int) -> TimeseriesdecompseatsGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompseatsGraphN::len(self : TimeseriesdecompseatsGraphN) -> Int { self.size }

pub fn TimeseriesdecompseatsGraphN::get(self : TimeseriesdecompseatsGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompseatsGraphN::set(self : TimeseriesdecompseatsGraphN, i : Int, v : Double) -> TimeseriesdecompseatsGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompseatsGraphN::sum(self : TimeseriesdecompseatsGraphN) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompseatsGraphN::mean(self : TimeseriesdecompseatsGraphN) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompseatsGraphN::scale(self : TimeseriesdecompseatsGraphN, f : Double) -> TimeseriesdecompseatsGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompseatsGraphN::add(self : TimeseriesdecompseatsGraphN, other : TimeseriesdecompseatsGraphN) -> TimeseriesdecompseatsGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompseatsGraphN::copy(self : TimeseriesdecompseatsGraphN) -> TimeseriesdecompseatsGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompseatsGraphN::fill(self : TimeseriesdecompseatsGraphN, v : Double) -> TimeseriesdecompseatsGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompseatsGraphN::min(self : TimeseriesdecompseatsGraphN) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompseatsGraphN::max(self : TimeseriesdecompseatsGraphN) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompseatsGraphN::to_string(self : TimeseriesdecompseatsGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompseatsNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_seats_node_make(size : Int) -> TimeseriesdecompseatsNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompseatsNode::len(self : TimeseriesdecompseatsNode) -> Int { self.size }

pub fn TimeseriesdecompseatsNode::get(self : TimeseriesdecompseatsNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompseatsNode::set(self : TimeseriesdecompseatsNode, i : Int, v : Double) -> TimeseriesdecompseatsNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompseatsNode::sum(self : TimeseriesdecompseatsNode) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompseatsNode::mean(self : TimeseriesdecompseatsNode) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompseatsNode::scale(self : TimeseriesdecompseatsNode, f : Double) -> TimeseriesdecompseatsNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompseatsNode::add(self : TimeseriesdecompseatsNode, other : TimeseriesdecompseatsNode) -> TimeseriesdecompseatsNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompseatsNode::copy(self : TimeseriesdecompseatsNode) -> TimeseriesdecompseatsNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompseatsNode::fill(self : TimeseriesdecompseatsNode, v : Double) -> TimeseriesdecompseatsNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompseatsNode::min(self : TimeseriesdecompseatsNode) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompseatsNode::max(self : TimeseriesdecompseatsNode) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompseatsNode::to_string(self : TimeseriesdecompseatsNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompseatsEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_seats_edge_make(size : Int) -> TimeseriesdecompseatsEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompseatsEdge::len(self : TimeseriesdecompseatsEdge) -> Int { self.size }

pub fn TimeseriesdecompseatsEdge::get(self : TimeseriesdecompseatsEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompseatsEdge::set(self : TimeseriesdecompseatsEdge, i : Int, v : Double) -> TimeseriesdecompseatsEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompseatsEdge::sum(self : TimeseriesdecompseatsEdge) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompseatsEdge::mean(self : TimeseriesdecompseatsEdge) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompseatsEdge::scale(self : TimeseriesdecompseatsEdge, f : Double) -> TimeseriesdecompseatsEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompseatsEdge::add(self : TimeseriesdecompseatsEdge, other : TimeseriesdecompseatsEdge) -> TimeseriesdecompseatsEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompseatsEdge::copy(self : TimeseriesdecompseatsEdge) -> TimeseriesdecompseatsEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompseatsEdge::fill(self : TimeseriesdecompseatsEdge, v : Double) -> TimeseriesdecompseatsEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompseatsEdge::min(self : TimeseriesdecompseatsEdge) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompseatsEdge::max(self : TimeseriesdecompseatsEdge) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompseatsEdge::to_string(self : TimeseriesdecompseatsEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompseatsPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_seats_path_make(size : Int) -> TimeseriesdecompseatsPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompseatsPath::len(self : TimeseriesdecompseatsPath) -> Int { self.size }

pub fn TimeseriesdecompseatsPath::get(self : TimeseriesdecompseatsPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompseatsPath::set(self : TimeseriesdecompseatsPath, i : Int, v : Double) -> TimeseriesdecompseatsPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompseatsPath::sum(self : TimeseriesdecompseatsPath) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompseatsPath::mean(self : TimeseriesdecompseatsPath) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompseatsPath::scale(self : TimeseriesdecompseatsPath, f : Double) -> TimeseriesdecompseatsPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompseatsPath::add(self : TimeseriesdecompseatsPath, other : TimeseriesdecompseatsPath) -> TimeseriesdecompseatsPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompseatsPath::copy(self : TimeseriesdecompseatsPath) -> TimeseriesdecompseatsPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompseatsPath::fill(self : TimeseriesdecompseatsPath, v : Double) -> TimeseriesdecompseatsPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompseatsPath::min(self : TimeseriesdecompseatsPath) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompseatsPath::max(self : TimeseriesdecompseatsPath) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompseatsPath::to_string(self : TimeseriesdecompseatsPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompseatsCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_seats_cluster_make(size : Int) -> TimeseriesdecompseatsCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompseatsCluster::len(self : TimeseriesdecompseatsCluster) -> Int { self.size }

pub fn TimeseriesdecompseatsCluster::get(self : TimeseriesdecompseatsCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompseatsCluster::set(self : TimeseriesdecompseatsCluster, i : Int, v : Double) -> TimeseriesdecompseatsCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompseatsCluster::sum(self : TimeseriesdecompseatsCluster) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompseatsCluster::mean(self : TimeseriesdecompseatsCluster) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompseatsCluster::scale(self : TimeseriesdecompseatsCluster, f : Double) -> TimeseriesdecompseatsCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompseatsCluster::add(self : TimeseriesdecompseatsCluster, other : TimeseriesdecompseatsCluster) -> TimeseriesdecompseatsCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompseatsCluster::copy(self : TimeseriesdecompseatsCluster) -> TimeseriesdecompseatsCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompseatsCluster::fill(self : TimeseriesdecompseatsCluster, v : Double) -> TimeseriesdecompseatsCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompseatsCluster::min(self : TimeseriesdecompseatsCluster) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompseatsCluster::max(self : TimeseriesdecompseatsCluster) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompseatsCluster::to_string(self : TimeseriesdecompseatsCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompseatsModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_seats_model_make(size : Int) -> TimeseriesdecompseatsModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompseatsModel::len(self : TimeseriesdecompseatsModel) -> Int { self.size }

pub fn TimeseriesdecompseatsModel::get(self : TimeseriesdecompseatsModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompseatsModel::set(self : TimeseriesdecompseatsModel, i : Int, v : Double) -> TimeseriesdecompseatsModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompseatsModel::sum(self : TimeseriesdecompseatsModel) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompseatsModel::mean(self : TimeseriesdecompseatsModel) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompseatsModel::scale(self : TimeseriesdecompseatsModel, f : Double) -> TimeseriesdecompseatsModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompseatsModel::add(self : TimeseriesdecompseatsModel, other : TimeseriesdecompseatsModel) -> TimeseriesdecompseatsModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompseatsModel::copy(self : TimeseriesdecompseatsModel) -> TimeseriesdecompseatsModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompseatsModel::fill(self : TimeseriesdecompseatsModel, v : Double) -> TimeseriesdecompseatsModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompseatsModel::min(self : TimeseriesdecompseatsModel) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompseatsModel::max(self : TimeseriesdecompseatsModel) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompseatsModel::to_string(self : TimeseriesdecompseatsModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompseatsLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_seats_layer_make(size : Int) -> TimeseriesdecompseatsLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompseatsLayer::len(self : TimeseriesdecompseatsLayer) -> Int { self.size }

pub fn TimeseriesdecompseatsLayer::get(self : TimeseriesdecompseatsLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompseatsLayer::set(self : TimeseriesdecompseatsLayer, i : Int, v : Double) -> TimeseriesdecompseatsLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompseatsLayer::sum(self : TimeseriesdecompseatsLayer) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompseatsLayer::mean(self : TimeseriesdecompseatsLayer) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompseatsLayer::scale(self : TimeseriesdecompseatsLayer, f : Double) -> TimeseriesdecompseatsLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompseatsLayer::add(self : TimeseriesdecompseatsLayer, other : TimeseriesdecompseatsLayer) -> TimeseriesdecompseatsLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompseatsLayer::copy(self : TimeseriesdecompseatsLayer) -> TimeseriesdecompseatsLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompseatsLayer::fill(self : TimeseriesdecompseatsLayer, v : Double) -> TimeseriesdecompseatsLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompseatsLayer::min(self : TimeseriesdecompseatsLayer) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompseatsLayer::max(self : TimeseriesdecompseatsLayer) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompseatsLayer::to_string(self : TimeseriesdecompseatsLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompseatsBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_seats_buffer_make(size : Int) -> TimeseriesdecompseatsBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompseatsBuffer::len(self : TimeseriesdecompseatsBuffer) -> Int { self.size }

pub fn TimeseriesdecompseatsBuffer::get(self : TimeseriesdecompseatsBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompseatsBuffer::set(self : TimeseriesdecompseatsBuffer, i : Int, v : Double) -> TimeseriesdecompseatsBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompseatsBuffer::sum(self : TimeseriesdecompseatsBuffer) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompseatsBuffer::mean(self : TimeseriesdecompseatsBuffer) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompseatsBuffer::scale(self : TimeseriesdecompseatsBuffer, f : Double) -> TimeseriesdecompseatsBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompseatsBuffer::add(self : TimeseriesdecompseatsBuffer, other : TimeseriesdecompseatsBuffer) -> TimeseriesdecompseatsBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompseatsBuffer::copy(self : TimeseriesdecompseatsBuffer) -> TimeseriesdecompseatsBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompseatsBuffer::fill(self : TimeseriesdecompseatsBuffer, v : Double) -> TimeseriesdecompseatsBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompseatsBuffer::min(self : TimeseriesdecompseatsBuffer) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompseatsBuffer::max(self : TimeseriesdecompseatsBuffer) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompseatsBuffer::to_string(self : TimeseriesdecompseatsBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompseatsCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_seats_cursor_make(size : Int) -> TimeseriesdecompseatsCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompseatsCursor::len(self : TimeseriesdecompseatsCursor) -> Int { self.size }

pub fn TimeseriesdecompseatsCursor::get(self : TimeseriesdecompseatsCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompseatsCursor::set(self : TimeseriesdecompseatsCursor, i : Int, v : Double) -> TimeseriesdecompseatsCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompseatsCursor::sum(self : TimeseriesdecompseatsCursor) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompseatsCursor::mean(self : TimeseriesdecompseatsCursor) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompseatsCursor::scale(self : TimeseriesdecompseatsCursor, f : Double) -> TimeseriesdecompseatsCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompseatsCursor::add(self : TimeseriesdecompseatsCursor, other : TimeseriesdecompseatsCursor) -> TimeseriesdecompseatsCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompseatsCursor::copy(self : TimeseriesdecompseatsCursor) -> TimeseriesdecompseatsCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompseatsCursor::fill(self : TimeseriesdecompseatsCursor, v : Double) -> TimeseriesdecompseatsCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompseatsCursor::min(self : TimeseriesdecompseatsCursor) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompseatsCursor::max(self : TimeseriesdecompseatsCursor) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompseatsCursor::to_string(self : TimeseriesdecompseatsCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompseatsView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_seats_view_make(size : Int) -> TimeseriesdecompseatsView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompseatsView::len(self : TimeseriesdecompseatsView) -> Int { self.size }

pub fn TimeseriesdecompseatsView::get(self : TimeseriesdecompseatsView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompseatsView::set(self : TimeseriesdecompseatsView, i : Int, v : Double) -> TimeseriesdecompseatsView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompseatsView::sum(self : TimeseriesdecompseatsView) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompseatsView::mean(self : TimeseriesdecompseatsView) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompseatsView::scale(self : TimeseriesdecompseatsView, f : Double) -> TimeseriesdecompseatsView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompseatsView::add(self : TimeseriesdecompseatsView, other : TimeseriesdecompseatsView) -> TimeseriesdecompseatsView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompseatsView::copy(self : TimeseriesdecompseatsView) -> TimeseriesdecompseatsView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompseatsView::fill(self : TimeseriesdecompseatsView, v : Double) -> TimeseriesdecompseatsView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompseatsView::min(self : TimeseriesdecompseatsView) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompseatsView::max(self : TimeseriesdecompseatsView) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompseatsView::to_string(self : TimeseriesdecompseatsView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompseatsRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_seats_range_make(size : Int) -> TimeseriesdecompseatsRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompseatsRange::len(self : TimeseriesdecompseatsRange) -> Int { self.size }

pub fn TimeseriesdecompseatsRange::get(self : TimeseriesdecompseatsRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompseatsRange::set(self : TimeseriesdecompseatsRange, i : Int, v : Double) -> TimeseriesdecompseatsRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompseatsRange::sum(self : TimeseriesdecompseatsRange) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompseatsRange::mean(self : TimeseriesdecompseatsRange) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompseatsRange::scale(self : TimeseriesdecompseatsRange, f : Double) -> TimeseriesdecompseatsRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompseatsRange::add(self : TimeseriesdecompseatsRange, other : TimeseriesdecompseatsRange) -> TimeseriesdecompseatsRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompseatsRange::copy(self : TimeseriesdecompseatsRange) -> TimeseriesdecompseatsRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompseatsRange::fill(self : TimeseriesdecompseatsRange, v : Double) -> TimeseriesdecompseatsRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompseatsRange::min(self : TimeseriesdecompseatsRange) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompseatsRange::max(self : TimeseriesdecompseatsRange) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompseatsRange::to_string(self : TimeseriesdecompseatsRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompseatsSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_seats_slice_make(size : Int) -> TimeseriesdecompseatsSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompseatsSlice::len(self : TimeseriesdecompseatsSlice) -> Int { self.size }

pub fn TimeseriesdecompseatsSlice::get(self : TimeseriesdecompseatsSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompseatsSlice::set(self : TimeseriesdecompseatsSlice, i : Int, v : Double) -> TimeseriesdecompseatsSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompseatsSlice::sum(self : TimeseriesdecompseatsSlice) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompseatsSlice::mean(self : TimeseriesdecompseatsSlice) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompseatsSlice::scale(self : TimeseriesdecompseatsSlice, f : Double) -> TimeseriesdecompseatsSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompseatsSlice::add(self : TimeseriesdecompseatsSlice, other : TimeseriesdecompseatsSlice) -> TimeseriesdecompseatsSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompseatsSlice::copy(self : TimeseriesdecompseatsSlice) -> TimeseriesdecompseatsSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompseatsSlice::fill(self : TimeseriesdecompseatsSlice, v : Double) -> TimeseriesdecompseatsSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompseatsSlice::min(self : TimeseriesdecompseatsSlice) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompseatsSlice::max(self : TimeseriesdecompseatsSlice) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompseatsSlice::to_string(self : TimeseriesdecompseatsSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

