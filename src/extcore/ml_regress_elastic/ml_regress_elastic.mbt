///===
/// extcore/ml_regress_elastic

pub(all) struct MlregresselasticPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_regress_elastic_make_point(x : Double, y : Double) -> MlregresselasticPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_regress_elastic_make_point3(x : Double, y : Double, z : Double) -> MlregresselasticPoint {
  { x, y, z, label: 0 }
}

pub fn MlregresselasticPoint::x(self : MlregresselasticPoint) -> Double { self.x }

pub fn MlregresselasticPoint::y(self : MlregresselasticPoint) -> Double { self.y }

pub fn MlregresselasticPoint::z(self : MlregresselasticPoint) -> Double { self.z }

pub fn MlregresselasticPoint::label(self : MlregresselasticPoint) -> Int { self.label }

pub fn MlregresselasticPoint::dist(self : MlregresselasticPoint, other : MlregresselasticPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlregresselasticPoint::add(self : MlregresselasticPoint, other : MlregresselasticPoint) -> MlregresselasticPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlregresselasticPoint::sub(self : MlregresselasticPoint, other : MlregresselasticPoint) -> MlregresselasticPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlregresselasticPoint::scale(self : MlregresselasticPoint, s : Double) -> MlregresselasticPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlregresselasticPoint::dot(self : MlregresselasticPoint, other : MlregresselasticPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlregresselasticPoint::cross(self : MlregresselasticPoint, other : MlregresselasticPoint) -> MlregresselasticPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlregresselasticPoint::norm(self : MlregresselasticPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlregresselasticPoint::normalize(self : MlregresselasticPoint) -> MlregresselasticPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlregresselasticPoint::negate(self : MlregresselasticPoint) -> MlregresselasticPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlregresselasticPoint::mid(self : MlregresselasticPoint, other : MlregresselasticPoint) -> MlregresselasticPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlregresselasticPoint::lerp(self : MlregresselasticPoint, other : MlregresselasticPoint, t : Double) -> MlregresselasticPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlregresselasticPoint::to_string(self : MlregresselasticPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlregresselasticSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_regress_elastic_make_series(vals : Array[Double], name : String) -> MlregresselasticSeries {
  { vals, name, meta: 0 }
}

pub fn MlregresselasticSeries::len(self : MlregresselasticSeries) -> Int { self.vals.length() }

pub fn MlregresselasticSeries::sum(self : MlregresselasticSeries) -> Double { @_common.sum(self.vals) }

pub fn MlregresselasticSeries::mean(self : MlregresselasticSeries) -> Double { @_common.mean(self.vals) }

pub fn MlregresselasticSeries::min(self : MlregresselasticSeries) -> Double { @_common.min(self.vals) }

pub fn MlregresselasticSeries::max(self : MlregresselasticSeries) -> Double { @_common.max(self.vals) }

pub fn MlregresselasticSeries::range(self : MlregresselasticSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlregresselasticSeries::variance(self : MlregresselasticSeries) -> Double { @_common.variance(self.vals) }

pub fn MlregresselasticSeries::std(self : MlregresselasticSeries) -> Double { @_common.std(self.vals) }

pub fn MlregresselasticSeries::median(self : MlregresselasticSeries) -> Double { @_common.median(self.vals) }

pub fn MlregresselasticSeries::scale(self : MlregresselasticSeries, f : Double) -> MlregresselasticSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlregresselasticSeries::add(self : MlregresselasticSeries, other : MlregresselasticSeries) -> MlregresselasticSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlregresselasticSeries::sub(self : MlregresselasticSeries, other : MlregresselasticSeries) -> MlregresselasticSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlregresselasticSeries::normalize(self : MlregresselasticSeries) -> MlregresselasticSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlregresselasticSeries::cumsum(self : MlregresselasticSeries) -> MlregresselasticSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlregresselasticSeries::to_string(self : MlregresselasticSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlregresselasticMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_regress_elastic_make_matrix(rows : Int, cols : Int, val : Double) -> MlregresselasticMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn ml_regress_elastic_matrix_identity(n : Int) -> MlregresselasticMatrix {
  let m = ml_regress_elastic_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlregresselasticMatrix::get(self : MlregresselasticMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlregresselasticMatrix::transpose(self : MlregresselasticMatrix) -> MlregresselasticMatrix {
  let result = ml_regress_elastic_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlregresselasticMatrix::add(self : MlregresselasticMatrix, other : MlregresselasticMatrix) -> MlregresselasticMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_regress_elastic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlregresselasticMatrix::scale(self : MlregresselasticMatrix, s : Double) -> MlregresselasticMatrix {
  let result = ml_regress_elastic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlregresselasticMatrix::multiply(self : MlregresselasticMatrix, other : MlregresselasticMatrix) -> MlregresselasticMatrix {
  if self.cols != other.rows { return ml_regress_elastic_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_regress_elastic_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn MlregresselasticMatrix::trace(self : MlregresselasticMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlregresselasticMatrix::det(self : MlregresselasticMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlregresselasticMatrix::norm(self : MlregresselasticMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlregresselasticMatrix::to_string(self : MlregresselasticMatrix) -> String {
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

pub(all) struct MlregresselasticVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_regress_elastic_make_vector(comps : Array[Double]) -> MlregresselasticVector {
  { comps, dim: comps.length() }
}

pub fn ml_regress_elastic_vector_zero(dim : Int) -> MlregresselasticVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlregresselasticVector::add(self : MlregresselasticVector, other : MlregresselasticVector) -> MlregresselasticVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlregresselasticVector::sub(self : MlregresselasticVector, other : MlregresselasticVector) -> MlregresselasticVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlregresselasticVector::scale(self : MlregresselasticVector, s : Double) -> MlregresselasticVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlregresselasticVector::dot(self : MlregresselasticVector, other : MlregresselasticVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlregresselasticVector::norm(self : MlregresselasticVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlregresselasticVector::normalize(self : MlregresselasticVector) -> MlregresselasticVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlregresselasticVector::dist(self : MlregresselasticVector, other : MlregresselasticVector) -> Double {
  self.sub(other).norm()
}

pub fn MlregresselasticVector::to_string(self : MlregresselasticVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlregresselasticFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_elastic_frame_make(size : Int) -> MlregresselasticFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresselasticFrame::len(self : MlregresselasticFrame) -> Int { self.size }

pub fn MlregresselasticFrame::get(self : MlregresselasticFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresselasticFrame::set(self : MlregresselasticFrame, i : Int, v : Double) -> MlregresselasticFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresselasticFrame::sum(self : MlregresselasticFrame) -> Double { @_common.sum(self.data) }

pub fn MlregresselasticFrame::mean(self : MlregresselasticFrame) -> Double { @_common.mean(self.data) }

pub fn MlregresselasticFrame::scale(self : MlregresselasticFrame, f : Double) -> MlregresselasticFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresselasticFrame::add(self : MlregresselasticFrame, other : MlregresselasticFrame) -> MlregresselasticFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresselasticFrame::copy(self : MlregresselasticFrame) -> MlregresselasticFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresselasticFrame::fill(self : MlregresselasticFrame, v : Double) -> MlregresselasticFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresselasticFrame::min(self : MlregresselasticFrame) -> Double { @_common.min(self.data) }

pub fn MlregresselasticFrame::max(self : MlregresselasticFrame) -> Double { @_common.max(self.data) }

pub fn MlregresselasticFrame::to_string(self : MlregresselasticFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresselasticTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_elastic_table_make(size : Int) -> MlregresselasticTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresselasticTable::len(self : MlregresselasticTable) -> Int { self.size }

pub fn MlregresselasticTable::get(self : MlregresselasticTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresselasticTable::set(self : MlregresselasticTable, i : Int, v : Double) -> MlregresselasticTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresselasticTable::sum(self : MlregresselasticTable) -> Double { @_common.sum(self.data) }

pub fn MlregresselasticTable::mean(self : MlregresselasticTable) -> Double { @_common.mean(self.data) }

pub fn MlregresselasticTable::scale(self : MlregresselasticTable, f : Double) -> MlregresselasticTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresselasticTable::add(self : MlregresselasticTable, other : MlregresselasticTable) -> MlregresselasticTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresselasticTable::copy(self : MlregresselasticTable) -> MlregresselasticTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresselasticTable::fill(self : MlregresselasticTable, v : Double) -> MlregresselasticTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresselasticTable::min(self : MlregresselasticTable) -> Double { @_common.min(self.data) }

pub fn MlregresselasticTable::max(self : MlregresselasticTable) -> Double { @_common.max(self.data) }

pub fn MlregresselasticTable::to_string(self : MlregresselasticTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresselasticGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_elastic_graphn_make(size : Int) -> MlregresselasticGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresselasticGraphN::len(self : MlregresselasticGraphN) -> Int { self.size }

pub fn MlregresselasticGraphN::get(self : MlregresselasticGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresselasticGraphN::set(self : MlregresselasticGraphN, i : Int, v : Double) -> MlregresselasticGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresselasticGraphN::sum(self : MlregresselasticGraphN) -> Double { @_common.sum(self.data) }

pub fn MlregresselasticGraphN::mean(self : MlregresselasticGraphN) -> Double { @_common.mean(self.data) }

pub fn MlregresselasticGraphN::scale(self : MlregresselasticGraphN, f : Double) -> MlregresselasticGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresselasticGraphN::add(self : MlregresselasticGraphN, other : MlregresselasticGraphN) -> MlregresselasticGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresselasticGraphN::copy(self : MlregresselasticGraphN) -> MlregresselasticGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresselasticGraphN::fill(self : MlregresselasticGraphN, v : Double) -> MlregresselasticGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresselasticGraphN::min(self : MlregresselasticGraphN) -> Double { @_common.min(self.data) }

pub fn MlregresselasticGraphN::max(self : MlregresselasticGraphN) -> Double { @_common.max(self.data) }

pub fn MlregresselasticGraphN::to_string(self : MlregresselasticGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresselasticNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_elastic_node_make(size : Int) -> MlregresselasticNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresselasticNode::len(self : MlregresselasticNode) -> Int { self.size }

pub fn MlregresselasticNode::get(self : MlregresselasticNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresselasticNode::set(self : MlregresselasticNode, i : Int, v : Double) -> MlregresselasticNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresselasticNode::sum(self : MlregresselasticNode) -> Double { @_common.sum(self.data) }

pub fn MlregresselasticNode::mean(self : MlregresselasticNode) -> Double { @_common.mean(self.data) }

pub fn MlregresselasticNode::scale(self : MlregresselasticNode, f : Double) -> MlregresselasticNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresselasticNode::add(self : MlregresselasticNode, other : MlregresselasticNode) -> MlregresselasticNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresselasticNode::copy(self : MlregresselasticNode) -> MlregresselasticNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresselasticNode::fill(self : MlregresselasticNode, v : Double) -> MlregresselasticNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresselasticNode::min(self : MlregresselasticNode) -> Double { @_common.min(self.data) }

pub fn MlregresselasticNode::max(self : MlregresselasticNode) -> Double { @_common.max(self.data) }

pub fn MlregresselasticNode::to_string(self : MlregresselasticNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresselasticEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_elastic_edge_make(size : Int) -> MlregresselasticEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresselasticEdge::len(self : MlregresselasticEdge) -> Int { self.size }

pub fn MlregresselasticEdge::get(self : MlregresselasticEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresselasticEdge::set(self : MlregresselasticEdge, i : Int, v : Double) -> MlregresselasticEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresselasticEdge::sum(self : MlregresselasticEdge) -> Double { @_common.sum(self.data) }

pub fn MlregresselasticEdge::mean(self : MlregresselasticEdge) -> Double { @_common.mean(self.data) }

pub fn MlregresselasticEdge::scale(self : MlregresselasticEdge, f : Double) -> MlregresselasticEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresselasticEdge::add(self : MlregresselasticEdge, other : MlregresselasticEdge) -> MlregresselasticEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresselasticEdge::copy(self : MlregresselasticEdge) -> MlregresselasticEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresselasticEdge::fill(self : MlregresselasticEdge, v : Double) -> MlregresselasticEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresselasticEdge::min(self : MlregresselasticEdge) -> Double { @_common.min(self.data) }

pub fn MlregresselasticEdge::max(self : MlregresselasticEdge) -> Double { @_common.max(self.data) }

pub fn MlregresselasticEdge::to_string(self : MlregresselasticEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresselasticPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_elastic_path_make(size : Int) -> MlregresselasticPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresselasticPath::len(self : MlregresselasticPath) -> Int { self.size }

pub fn MlregresselasticPath::get(self : MlregresselasticPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresselasticPath::set(self : MlregresselasticPath, i : Int, v : Double) -> MlregresselasticPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresselasticPath::sum(self : MlregresselasticPath) -> Double { @_common.sum(self.data) }

pub fn MlregresselasticPath::mean(self : MlregresselasticPath) -> Double { @_common.mean(self.data) }

pub fn MlregresselasticPath::scale(self : MlregresselasticPath, f : Double) -> MlregresselasticPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresselasticPath::add(self : MlregresselasticPath, other : MlregresselasticPath) -> MlregresselasticPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresselasticPath::copy(self : MlregresselasticPath) -> MlregresselasticPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresselasticPath::fill(self : MlregresselasticPath, v : Double) -> MlregresselasticPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresselasticPath::min(self : MlregresselasticPath) -> Double { @_common.min(self.data) }

pub fn MlregresselasticPath::max(self : MlregresselasticPath) -> Double { @_common.max(self.data) }

pub fn MlregresselasticPath::to_string(self : MlregresselasticPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresselasticCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_elastic_cluster_make(size : Int) -> MlregresselasticCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresselasticCluster::len(self : MlregresselasticCluster) -> Int { self.size }

pub fn MlregresselasticCluster::get(self : MlregresselasticCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresselasticCluster::set(self : MlregresselasticCluster, i : Int, v : Double) -> MlregresselasticCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresselasticCluster::sum(self : MlregresselasticCluster) -> Double { @_common.sum(self.data) }

pub fn MlregresselasticCluster::mean(self : MlregresselasticCluster) -> Double { @_common.mean(self.data) }

pub fn MlregresselasticCluster::scale(self : MlregresselasticCluster, f : Double) -> MlregresselasticCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresselasticCluster::add(self : MlregresselasticCluster, other : MlregresselasticCluster) -> MlregresselasticCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresselasticCluster::copy(self : MlregresselasticCluster) -> MlregresselasticCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresselasticCluster::fill(self : MlregresselasticCluster, v : Double) -> MlregresselasticCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresselasticCluster::min(self : MlregresselasticCluster) -> Double { @_common.min(self.data) }

pub fn MlregresselasticCluster::max(self : MlregresselasticCluster) -> Double { @_common.max(self.data) }

pub fn MlregresselasticCluster::to_string(self : MlregresselasticCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresselasticModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_elastic_model_make(size : Int) -> MlregresselasticModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresselasticModel::len(self : MlregresselasticModel) -> Int { self.size }

pub fn MlregresselasticModel::get(self : MlregresselasticModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresselasticModel::set(self : MlregresselasticModel, i : Int, v : Double) -> MlregresselasticModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresselasticModel::sum(self : MlregresselasticModel) -> Double { @_common.sum(self.data) }

pub fn MlregresselasticModel::mean(self : MlregresselasticModel) -> Double { @_common.mean(self.data) }

pub fn MlregresselasticModel::scale(self : MlregresselasticModel, f : Double) -> MlregresselasticModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresselasticModel::add(self : MlregresselasticModel, other : MlregresselasticModel) -> MlregresselasticModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresselasticModel::copy(self : MlregresselasticModel) -> MlregresselasticModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresselasticModel::fill(self : MlregresselasticModel, v : Double) -> MlregresselasticModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresselasticModel::min(self : MlregresselasticModel) -> Double { @_common.min(self.data) }

pub fn MlregresselasticModel::max(self : MlregresselasticModel) -> Double { @_common.max(self.data) }

pub fn MlregresselasticModel::to_string(self : MlregresselasticModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresselasticLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_elastic_layer_make(size : Int) -> MlregresselasticLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresselasticLayer::len(self : MlregresselasticLayer) -> Int { self.size }

pub fn MlregresselasticLayer::get(self : MlregresselasticLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresselasticLayer::set(self : MlregresselasticLayer, i : Int, v : Double) -> MlregresselasticLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresselasticLayer::sum(self : MlregresselasticLayer) -> Double { @_common.sum(self.data) }

pub fn MlregresselasticLayer::mean(self : MlregresselasticLayer) -> Double { @_common.mean(self.data) }

pub fn MlregresselasticLayer::scale(self : MlregresselasticLayer, f : Double) -> MlregresselasticLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresselasticLayer::add(self : MlregresselasticLayer, other : MlregresselasticLayer) -> MlregresselasticLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresselasticLayer::copy(self : MlregresselasticLayer) -> MlregresselasticLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresselasticLayer::fill(self : MlregresselasticLayer, v : Double) -> MlregresselasticLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresselasticLayer::min(self : MlregresselasticLayer) -> Double { @_common.min(self.data) }

pub fn MlregresselasticLayer::max(self : MlregresselasticLayer) -> Double { @_common.max(self.data) }

pub fn MlregresselasticLayer::to_string(self : MlregresselasticLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresselasticBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_elastic_buffer_make(size : Int) -> MlregresselasticBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresselasticBuffer::len(self : MlregresselasticBuffer) -> Int { self.size }

pub fn MlregresselasticBuffer::get(self : MlregresselasticBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresselasticBuffer::set(self : MlregresselasticBuffer, i : Int, v : Double) -> MlregresselasticBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresselasticBuffer::sum(self : MlregresselasticBuffer) -> Double { @_common.sum(self.data) }

pub fn MlregresselasticBuffer::mean(self : MlregresselasticBuffer) -> Double { @_common.mean(self.data) }

pub fn MlregresselasticBuffer::scale(self : MlregresselasticBuffer, f : Double) -> MlregresselasticBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresselasticBuffer::add(self : MlregresselasticBuffer, other : MlregresselasticBuffer) -> MlregresselasticBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresselasticBuffer::copy(self : MlregresselasticBuffer) -> MlregresselasticBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresselasticBuffer::fill(self : MlregresselasticBuffer, v : Double) -> MlregresselasticBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresselasticBuffer::min(self : MlregresselasticBuffer) -> Double { @_common.min(self.data) }

pub fn MlregresselasticBuffer::max(self : MlregresselasticBuffer) -> Double { @_common.max(self.data) }

pub fn MlregresselasticBuffer::to_string(self : MlregresselasticBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresselasticCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_elastic_cursor_make(size : Int) -> MlregresselasticCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresselasticCursor::len(self : MlregresselasticCursor) -> Int { self.size }

pub fn MlregresselasticCursor::get(self : MlregresselasticCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresselasticCursor::set(self : MlregresselasticCursor, i : Int, v : Double) -> MlregresselasticCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresselasticCursor::sum(self : MlregresselasticCursor) -> Double { @_common.sum(self.data) }

pub fn MlregresselasticCursor::mean(self : MlregresselasticCursor) -> Double { @_common.mean(self.data) }

pub fn MlregresselasticCursor::scale(self : MlregresselasticCursor, f : Double) -> MlregresselasticCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresselasticCursor::add(self : MlregresselasticCursor, other : MlregresselasticCursor) -> MlregresselasticCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresselasticCursor::copy(self : MlregresselasticCursor) -> MlregresselasticCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresselasticCursor::fill(self : MlregresselasticCursor, v : Double) -> MlregresselasticCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresselasticCursor::min(self : MlregresselasticCursor) -> Double { @_common.min(self.data) }

pub fn MlregresselasticCursor::max(self : MlregresselasticCursor) -> Double { @_common.max(self.data) }

pub fn MlregresselasticCursor::to_string(self : MlregresselasticCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresselasticView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_elastic_view_make(size : Int) -> MlregresselasticView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresselasticView::len(self : MlregresselasticView) -> Int { self.size }

pub fn MlregresselasticView::get(self : MlregresselasticView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresselasticView::set(self : MlregresselasticView, i : Int, v : Double) -> MlregresselasticView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresselasticView::sum(self : MlregresselasticView) -> Double { @_common.sum(self.data) }

pub fn MlregresselasticView::mean(self : MlregresselasticView) -> Double { @_common.mean(self.data) }

pub fn MlregresselasticView::scale(self : MlregresselasticView, f : Double) -> MlregresselasticView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresselasticView::add(self : MlregresselasticView, other : MlregresselasticView) -> MlregresselasticView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresselasticView::copy(self : MlregresselasticView) -> MlregresselasticView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresselasticView::fill(self : MlregresselasticView, v : Double) -> MlregresselasticView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresselasticView::min(self : MlregresselasticView) -> Double { @_common.min(self.data) }

pub fn MlregresselasticView::max(self : MlregresselasticView) -> Double { @_common.max(self.data) }

pub fn MlregresselasticView::to_string(self : MlregresselasticView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresselasticRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_elastic_range_make(size : Int) -> MlregresselasticRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresselasticRange::len(self : MlregresselasticRange) -> Int { self.size }

pub fn MlregresselasticRange::get(self : MlregresselasticRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresselasticRange::set(self : MlregresselasticRange, i : Int, v : Double) -> MlregresselasticRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresselasticRange::sum(self : MlregresselasticRange) -> Double { @_common.sum(self.data) }

pub fn MlregresselasticRange::mean(self : MlregresselasticRange) -> Double { @_common.mean(self.data) }

pub fn MlregresselasticRange::scale(self : MlregresselasticRange, f : Double) -> MlregresselasticRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresselasticRange::add(self : MlregresselasticRange, other : MlregresselasticRange) -> MlregresselasticRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresselasticRange::copy(self : MlregresselasticRange) -> MlregresselasticRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresselasticRange::fill(self : MlregresselasticRange, v : Double) -> MlregresselasticRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresselasticRange::min(self : MlregresselasticRange) -> Double { @_common.min(self.data) }

pub fn MlregresselasticRange::max(self : MlregresselasticRange) -> Double { @_common.max(self.data) }

pub fn MlregresselasticRange::to_string(self : MlregresselasticRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresselasticSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_elastic_slice_make(size : Int) -> MlregresselasticSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresselasticSlice::len(self : MlregresselasticSlice) -> Int { self.size }

pub fn MlregresselasticSlice::get(self : MlregresselasticSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresselasticSlice::set(self : MlregresselasticSlice, i : Int, v : Double) -> MlregresselasticSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresselasticSlice::sum(self : MlregresselasticSlice) -> Double { @_common.sum(self.data) }

pub fn MlregresselasticSlice::mean(self : MlregresselasticSlice) -> Double { @_common.mean(self.data) }

pub fn MlregresselasticSlice::scale(self : MlregresselasticSlice, f : Double) -> MlregresselasticSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresselasticSlice::add(self : MlregresselasticSlice, other : MlregresselasticSlice) -> MlregresselasticSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresselasticSlice::copy(self : MlregresselasticSlice) -> MlregresselasticSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresselasticSlice::fill(self : MlregresselasticSlice, v : Double) -> MlregresselasticSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresselasticSlice::min(self : MlregresselasticSlice) -> Double { @_common.min(self.data) }

pub fn MlregresselasticSlice::max(self : MlregresselasticSlice) -> Double { @_common.max(self.data) }

pub fn MlregresselasticSlice::to_string(self : MlregresselasticSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

